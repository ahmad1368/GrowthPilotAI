import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dev_status_selector.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The `req_code` + description + dev-status row atop a
/// [TraceabilityRequirementCard] (Issue #242) — split out to keep that
/// file under the 50-line guideline.
class TraceabilityRequirementHeader extends StatelessWidget {
  final TraceabilityController controller;
  final TraceableRequirementEntity requirement;

  const TraceabilityRequirementHeader({super.key, required this.controller, required this.requirement});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(requirement.reqCode,
            style: TextStyle(color: colors.primary, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(requirement.description, style: TextStyle(color: colors.foreground, fontSize: 13)),
        ),
        DevStatusSelector(
          value: requirement.devStatus,
          onChanged: (status) => controller.setDevStatus(requirement.id, status),
        ),
      ],
    );
  }
}
