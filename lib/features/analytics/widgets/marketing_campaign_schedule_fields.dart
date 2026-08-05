import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Payment-reliability filter, dispatch delay, and required ad-tier
/// selector for a new campaign (Issue #407, acceptance criteria 2-3) —
/// scheduling binds the campaign to a paid advertising tier instead of
/// a full date/time picker this app has no need for.
class MarketingCampaignScheduleFields extends StatelessWidget {
  final TextEditingController reliabilityController;
  final TextEditingController scheduleHoursController;
  final AdPackageType selectedTier;
  final ValueChanged<AdPackageType> onTierChanged;

  const MarketingCampaignScheduleFields({
    super.key,
    required this.reliabilityController,
    required this.scheduleHoursController,
    required this.selectedTier,
    required this.onTierChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Min payment reliability (0-100)'),
            controller: reliabilityController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Send in N hours'),
            controller: scheduleHoursController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        Wrap(spacing: 8, children: [
          for (final tier in AdPackageType.values)
            if (selectedTier == tier)
              ShadButton(onPressed: () => onTierChanged(tier), child: Text(tier.name))
            else
              ShadButton.outline(
                  onPressed: () => onTierChanged(tier), child: Text(tier.name)),
        ]),
      ],
    );
  }
}
