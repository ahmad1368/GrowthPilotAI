import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/business_compass_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_period_chips.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_sector_chips.dart';

/// Sector/period selectors plus the "last updated" stamp above the
/// Business Compass report widgets (Issue #84), extracted so
/// [BusinessCompassBody] stays within the file-size budget.
class CompassControlsRow extends StatelessWidget {
  final BusinessCompassController controller;

  const CompassControlsRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CompassSectorChips(
          selected: controller.selectedSector.value,
          onChanged: controller.changeSector,
        ),
        const SizedBox(height: 12),
        CompassPeriodChips(
          selected: controller.selectedPeriod.value,
          onChanged: controller.changePeriod,
        ),
        const SizedBox(height: 8),
        Text(
            'Last updated: ${controller.lastUpdatedAt.toString().split('.').first}',
            style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}
