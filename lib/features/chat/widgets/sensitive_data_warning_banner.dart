import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flat "you're about to send sensitive data" banner (Issue #88 scope
/// item 3), driven by [DetectSensitiveDataWarning]. No glassmorphism —
/// same flat-card precedent as VoiceCommandConfirmationToast (#154).
class SensitiveDataWarningBanner extends StatelessWidget {
  final String message;

  const SensitiveDataWarningBanner({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
          color: colors.card,
          border: Border.all(color: colors.destructive),
          borderRadius: BorderRadius.circular(8)),
      child: Text(message, style: TextStyle(color: colors.destructive, fontSize: 12)),
    );
  }
}
