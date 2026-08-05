import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_preview.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Body markup textarea with a bold/italic toolbar and a live preview
/// (Issue #407, acceptance criterion 1) — a lightweight
/// `**bold**`/`_italic_` editor stands in for a full WYSIWYG/HTML
/// component this app has no dependency on.
class MarketingCampaignComposerField extends StatelessWidget {
  final TextEditingController bodyController;
  final VoidCallback onChanged;

  const MarketingCampaignComposerField(
      {super.key, required this.bodyController, required this.onChanged});

  void _wrap(String token) {
    final selection = bodyController.selection;
    final text = bodyController.text;
    final start = selection.start < 0 ? text.length : selection.start;
    final end = selection.end < 0 ? text.length : selection.end;
    final replacement = '$token${text.substring(start, end)}$token';
    bodyController.text = text.replaceRange(start, end, replacement);
    bodyController.selection =
        TextSelection.collapsed(offset: start + replacement.length);
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(spacing: 8, children: [
          ShadButton.outline(onPressed: () => _wrap('**'), child: const Text('Bold')),
          ShadButton.outline(onPressed: () => _wrap('_'), child: const Text('Italic')),
        ]),
        const SizedBox(height: 8),
        ShadInput(
          placeholder: const Text('Body (use **bold** / _italic_)'),
          controller: bodyController,
          maxLines: 4,
          onChanged: (_) => onChanged(),
        ),
        const SizedBox(height: 8),
        MarketingCampaignPreview(markup: bodyController.text),
      ],
    );
  }
}
