import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Dashboard Gauge: showing the percentage" (Issue #243) — a plain
/// `CircularProgressIndicator` gauge instead of the issue's named
/// Syncfusion `SfRadialGauge` (commercial license; see PR notes, same
/// reasoning as #239).
class GoalCoverageGauge extends StatelessWidget {
  final double coverage;

  const GoalCoverageGauge({super.key, required this.coverage});

  Color _colorFor(double value) {
    if (value >= 0.8) return Colors.green;
    if (value >= 0.5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final color = _colorFor(coverage);
    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: coverage.clamp(0.0, 1.0),
            strokeWidth: 6,
            color: color,
            backgroundColor: color.withValues(alpha: 0.2),
          ),
          Text('${(coverage * 100).round()}%',
              style: TextStyle(color: colors.foreground, fontSize: 14, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
