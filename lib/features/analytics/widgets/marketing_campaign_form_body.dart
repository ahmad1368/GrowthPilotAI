import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_composer_field.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_form_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_schedule_fields.dart';

/// Scrollable body combining segmentation, composer, and scheduling
/// fields for the campaign form (Issue #407).
class MarketingCampaignFormBody extends StatelessWidget {
  final MarketingCampaignFormController form;
  final VoidCallback onChanged;

  const MarketingCampaignFormBody(
      {super.key, required this.form, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarketingCampaignFields(
            subjectController: form.subject,
            categoryController: form.category,
            regionController: form.region,
          ),
          const SizedBox(height: 8),
          MarketingCampaignComposerField(
            bodyController: form.body,
            onChanged: onChanged,
          ),
          const SizedBox(height: 8),
          MarketingCampaignScheduleFields(
            reliabilityController: form.reliability,
            scheduleHoursController: form.scheduleHours,
            selectedTier: form.tier,
            onTierChanged: (t) {
              form.tier = t;
              onChanged();
            },
          ),
          const SizedBox(height: 8),
          Text('Estimated reach: ~${form.estimatedAudience} merchants',
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
