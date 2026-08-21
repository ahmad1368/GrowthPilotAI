import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "The Founding Member badge is visible on the user's profile"
/// (Issue #191 AC) — a small flat chip, no glassmorphism.
class FoundingMemberBadge extends StatelessWidget {
  final int spotNumber;

  const FoundingMemberBadge({super.key, required this.spotNumber});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.primary),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.military_tech_rounded, size: 14, color: colors.primary),
        const SizedBox(width: 4),
        Text('Founding Member #$spotNumber',
            style: TextStyle(fontSize: 11, color: colors.primary, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
