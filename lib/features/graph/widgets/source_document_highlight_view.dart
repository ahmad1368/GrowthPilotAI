import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/highlighted_source_text.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Source Document Viewer... Smart Highlighting: when a requirement
/// card is selected, the viewer must automatically scroll to and
/// highlight the exact sentence" (Issue #231) — a plain-text viewer
/// using the [ExtractedRequirement.startIndex]/[endIndex] offsets
/// captured in Issue #229 (no real PDF pipeline exists; see PR notes).
class SourceDocumentHighlightView extends StatefulWidget {
  final RequirementTriageController controller;

  const SourceDocumentHighlightView({super.key, required this.controller});

  @override
  State<SourceDocumentHighlightView> createState() => _SourceDocumentHighlightViewState();
}

class _SourceDocumentHighlightViewState extends State<SourceDocumentHighlightView> {
  final _scrollController = ScrollController();
  Worker? _worker;

  @override
  void initState() {
    super.initState();
    _worker = ever(widget.controller.selectedIndex, (_) => _scrollToSelection());
  }

  void _scrollToSelection() {
    final text = widget.controller.sourceText.value;
    final index = widget.controller.selectedIndex.value;
    if (index == null || text.isEmpty || !_scrollController.hasClients) return;
    final start = widget.controller.requirements[index].startIndex;
    final target = _scrollController.position.maxScrollExtent * (start / text.length);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(target.clamp(0.0, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    _worker?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final text = widget.controller.sourceText.value;
      if (text.isEmpty) {
        return Text('No source document loaded.',
            style: TextStyle(color: colors.mutedForeground, fontSize: 12));
      }
      final index = widget.controller.selectedIndex.value;
      final requirement = index == null ? null : widget.controller.requirements[index];
      return SingleChildScrollView(
        controller: _scrollController,
        child: HighlightedSourceText(
            text: text, start: requirement?.startIndex, end: requirement?.endIndex),
      );
    });
  }
}
