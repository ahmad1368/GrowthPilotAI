import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// KPI Card view (Issue #261) — flat card, not the issue's literal
/// glassmorphism treatment (architecture forbids Glassmorphism/
/// BackdropFilter).
class InsightKpiCard extends StatelessWidget {
  final double total;
  final String summary;

  const InsightKpiCard({super.key, required this.total, required this.summary});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('\$${total.toStringAsFixed(2)}',
              style: TextStyle(
                  color: colors.foreground, fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(summary, style: TextStyle(color: colors.mutedForeground, fontSize: 13)),
        ],
      ),
    );
  }
}
