import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Confirmation Toast" (Issue #154 AC) — a flat card, not the issue's
/// literal Glassmorphism ask (architecture forbids Glassmorphism/
/// BackdropFilter; same precedent as #128/#152's flat chip bars).
class VoiceCommandConfirmationToast extends StatelessWidget {
  final String summary;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const VoiceCommandConfirmationToast({
    super.key,
    required this.summary,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Expanded(child: Text(summary, style: TextStyle(color: colors.foreground))),
        const SizedBox(width: 8),
        ShadButton.outline(onPressed: onCancel, child: const Text('Cancel')),
        const SizedBox(width: 8),
        ShadButton(onPressed: onConfirm, child: const Text('Confirm')),
      ]),
    );
  }
}
