import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_dev_status.dart';

/// "Status Indicators: `CircularProgressIndicator` for 'In Progress'
/// and a green `CheckCircle` for 'Completed'" (Issue #242).
class DevStatusIndicator extends StatelessWidget {
  final RequirementDevStatus status;

  const DevStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case RequirementDevStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green, size: 16);
      case RequirementDevStatus.inProgress:
        return const SizedBox(
            width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2));
      case RequirementDevStatus.pending:
        return const Icon(Icons.circle_outlined, color: Colors.grey, size: 16);
    }
  }
}
