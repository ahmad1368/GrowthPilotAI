import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Smart Match" badge (Issue #145 UI AC) — flat pill, not the issue's
/// literal Glassmorphism "vibrant, frosted-glass highlight" ask. Not yet
/// wired into the catalog grid screen.
class MatchScoreBadge extends StatelessWidget {
  final double score;

  const MatchScoreBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: colors.primary, borderRadius: BorderRadius.circular(20)),
      child: Text('${(score * 100).toStringAsFixed(0)}% match',
          style: TextStyle(fontSize: 11, color: colors.primaryForeground)),
    );
  }
}
