import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_triage_list.dart';
import 'package:growth_pilot_ai/features/graph/widgets/source_document_highlight_view.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Side-by-side with a Source Document Viewer (on Web) or as a toggle
/// (on Mobile)" (Issue #231).
class RequirementSourceSplitView extends StatefulWidget {
  final RequirementTriageController controller;

  const RequirementSourceSplitView({super.key, required this.controller});

  @override
  State<RequirementSourceSplitView> createState() => _RequirementSourceSplitViewState();
}

class _RequirementSourceSplitViewState extends State<RequirementSourceSplitView> {
  bool _showSource = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isWide = constraints.maxWidth >= 800;
      final list = RequirementTriageList(controller: widget.controller);
      final source = SourceDocumentHighlightView(controller: widget.controller);

      if (isWide) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: list),
            const SizedBox(width: 16),
            Expanded(child: source),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadButton.outline(
            onPressed: () => setState(() => _showSource = !_showSource),
            child: Text(_showSource ? 'Show Requirements' : 'Show Source Document'),
          ),
          const SizedBox(height: 8),
          _showSource ? source : list,
        ],
      );
    });
  }
}
