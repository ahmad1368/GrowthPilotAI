import 'package:flutter/material.dart';

/// Month label with an optional deficit warning icon (Issue #368).
class CashFlowMonthLabel extends StatelessWidget {
  final String monthLabel;
  final bool isDeficit;
  final Color color;

  const CashFlowMonthLabel({
    super.key,
    required this.monthLabel,
    required this.isDeficit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isDeficit) ...[
          Icon(Icons.warning_amber_rounded, size: 14, color: color),
          const SizedBox(width: 4),
        ],
        Flexible(
          child: Text(monthLabel, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
