import 'package:flutter/material.dart';

/// [Issue #837] Renders [InsightModel.efficiency] — previously parsed but
/// never actually displayed anywhere in InsightListItem.
class InsightEfficiencyRing extends StatelessWidget {
  final double percent; // 0.0 - 1.0
  final Color color;

  const InsightEfficiencyRing({super.key, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent.clamp(0.0, 1.0),
            strokeWidth: 4,
            backgroundColor: color.withValues(alpha: 0.15),
            valueColor: AlwaysStoppedAnimation(color),
          ),
          Text('${(percent * 100).round()}%',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
