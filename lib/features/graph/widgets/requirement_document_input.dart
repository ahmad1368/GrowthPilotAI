import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/document_processing_orchestrator_controller.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/document_reprocess_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Paste raw document text and run it through Issue #232's local
/// processing orchestrator (Upload -> Clean -> Extract -> Save) — no
/// document-upload pipeline is wired to this screen yet (see PR notes),
/// so this is the honest "manual paste" fallback, same pattern as
/// Issue #227's sanitization controller input.
class RequirementDocumentInput extends StatefulWidget {
  final DocumentProcessingOrchestratorController orchestrator;
  final RequirementTriageController triageController;

  const RequirementDocumentInput({
    super.key,
    required this.orchestrator,
    required this.triageController,
  });

  @override
  State<RequirementDocumentInput> createState() => _RequirementDocumentInputState();
}

class _RequirementDocumentInputState extends State<RequirementDocumentInput> {
  final _textController = TextEditingController();

  Future<void> _analyze() async {
    final text = _textController.text;
    final cached = widget.orchestrator.findCached(text);
    final reuse = cached == null
        ? true
        : await showDialog<bool>(context: context, builder: (_) => const DocumentReprocessDialog()) ??
            true;

    final record = await widget.orchestrator.process(text, reuseCache: reuse);
    if (record == null) return;

    widget.triageController.loadFromRecord(record);
    Get.snackbar('Analysis complete', 'Requirements are ready for review.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadTextarea(controller: _textController, placeholder: const Text('Paste document text...')),
        const SizedBox(height: 8),
        ShadButton(onPressed: _analyze, child: const Text('Analyze')),
      ],
    );
  }
}
