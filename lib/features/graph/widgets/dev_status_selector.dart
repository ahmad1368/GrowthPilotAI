import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_dev_status.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dev_status_indicator.dart';

/// Dropdown to change a requirement's `dev_status` (Issue #242).
class DevStatusSelector extends StatelessWidget {
  final RequirementDevStatus value;
  final ValueChanged<RequirementDevStatus> onChanged;

  const DevStatusSelector({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<RequirementDevStatus>(
      value: value,
      underline: const SizedBox.shrink(),
      onChanged: (v) => v == null ? null : onChanged(v),
      items: [
        for (final status in RequirementDevStatus.values)
          DropdownMenuItem(
            value: status,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DevStatusIndicator(status: status),
                const SizedBox(width: 6),
                Text(status.name),
              ],
            ),
          ),
      ],
    );
  }
}
