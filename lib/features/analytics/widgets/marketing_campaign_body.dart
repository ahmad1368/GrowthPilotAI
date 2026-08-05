import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/marketing_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/marketing_campaign_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/marketing_campaign_view.dart';

/// Owns the campaign list (Issue #407).
class MarketingCampaignBody extends StatefulWidget {
  final List<MarketingCampaignEntity> initialCampaigns;

  const MarketingCampaignBody({super.key, required this.initialCampaigns});

  @override
  State<MarketingCampaignBody> createState() => _MarketingCampaignBodyState();
}

class _MarketingCampaignBodyState extends State<MarketingCampaignBody> {
  late List<MarketingCampaignEntity> _campaigns = widget.initialCampaigns;
  late final _actions = MarketingCampaignActions(MarketingCampaignRepository(
      Get.find<ObjectBox>().store.box<MarketingCampaignEntity>()));
  Future<void> _create() async {
    final campaign = await showMarketingCampaignDialog(context);
    if (campaign == null) return;
    _actions.repo.save(campaign);
    setState(() => _campaigns = [..._campaigns, campaign]);
  }

  void _clone(MarketingCampaignEntity campaign) {
    setState(() => _campaigns = [..._campaigns, _actions.clone(campaign)]);
  }

  void _send(MarketingCampaignEntity campaign) {
    final sent = _actions.send(campaign);
    if (sent == null) return;
    setState(() => _campaigns = _actions.replaceInList(_campaigns, sent));
  }

  @override
  Widget build(BuildContext context) {
    return MarketingCampaignView(
      campaigns: _campaigns,
      onCreate: _create,
      onClone: _clone,
      onSend: _send,
    );
  }
}
