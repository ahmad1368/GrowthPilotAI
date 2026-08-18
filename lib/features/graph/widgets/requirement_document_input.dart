import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/controllers/text_sanitization_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Paste raw document text and analyze it (Issue #231's triage screen
/// entry point) — no document-upload pipeline is wired to this screen
/// yet (see PR notes), so this is the honest "manual paste" fallback,
/// same pattern as Issue #227's sanitization controller input.
class RequirementDocumentInput extends StatefulWidget {
  final TextSanitizationController sanitizationController;
  final RequirementTriageController triageController;

  const RequirementDocumentInput({
    super.key,
    required this.sanitizationController,
    required this.triageController,
  });

  @override
  State<RequirementDocumentInput> createState() => _RequirementDocumentInputState();
}

class _RequirementDocumentInputState extends State<RequirementDocumentInput> {
  final _textController = TextEditingController();

  void _analyze() {
    widget.sanitizationController.sanitize(_textController.text);
    final sanitized = widget.sanitizationController.result.value?.sanitizedText ?? '';
    widget.triageController.loadFromText(sanitized);
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
