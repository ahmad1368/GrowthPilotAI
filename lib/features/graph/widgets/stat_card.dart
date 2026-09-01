import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/trend_direction.dart';
import 'package:growth_pilot_ai/features/graph/widgets/trend_icon.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Custom KPI Cards... Iconography, Semantic Coloring, Trend
/// Indicators" (Issue #234) — flat, no Glassmorphism (per this app's
/// design system, not the issue's literal ask; see PR notes).
class StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;
  final TrendDirection trend;
  final VoidCallback? onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
    this.trend = TrendDirection.none,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: accentColor, size: 18),
                const SizedBox(width: 6),
                Expanded(
                    child: Text(label,
                        style: TextStyle(color: colors.mutedForeground, fontSize: 11),
                        overflow: TextOverflow.ellipsis)),
                TrendIcon(trend: trend),
              ],
            ),
            const SizedBox(height: 6),
            Text(value,
                style: TextStyle(color: colors.foreground, fontSize: 20, fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
