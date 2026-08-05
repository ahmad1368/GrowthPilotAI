import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_form_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful campaign composer form for [showMarketingCampaignDialog]
/// (Issue #407).
class MarketingCampaignDialogContent extends StatefulWidget {
  const MarketingCampaignDialogContent({super.key});

  @override
  State<MarketingCampaignDialogContent> createState() =>
      _MarketingCampaignDialogContentState();
}

class _MarketingCampaignDialogContentState
    extends State<MarketingCampaignDialogContent> {
  final _form = MarketingCampaignFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop(_form.build());
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('New Marketing Campaign'),
      description: MarketingCampaignFormBody(
        form: _form,
        onChanged: () => setState(() {}),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save Draft')),
      ],
    );
  }
}
