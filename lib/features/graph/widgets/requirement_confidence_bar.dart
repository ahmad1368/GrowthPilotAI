import 'package:flutter/material.dart';

/// "Confidence Indicators... color-coded bar (Heatmap style)" (Issue
/// #231) — red below 60%, orange below 80%, green above.
class RequirementConfidenceBar extends StatelessWidget {
  final double confidence;

  const RequirementConfidenceBar({super.key, required this.confidence});

  Color _colorFor(double value) {
    if (value < 0.6) return Colors.red;
    if (value < 0.8) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(confidence);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 6,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: confidence.clamp(0.0, 1.0),
            child: DecoratedBox(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
          ),
        ),
        const SizedBox(width: 6),
        Text('${(confidence * 100).round()}%', style: TextStyle(color: color, fontSize: 10)),
      ],
    );
  }
}
