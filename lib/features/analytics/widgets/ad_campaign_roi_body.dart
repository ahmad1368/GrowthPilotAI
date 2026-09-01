import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_ad_campaign_roi.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/ad_campaign_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_campaign_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_campaign_roi_view.dart';

/// Owns the logged-campaign list (Issue #366), refreshing it locally
/// after each quick-add insert — mirrors [WasteLogBody]'s pattern.
class AdCampaignRoiBody extends StatefulWidget {
  final List<AdCampaignEntity> initialCampaigns;
  final List<TransactionEntity> transactions;

  const AdCampaignRoiBody(
      {super.key, required this.initialCampaigns, required this.transactions});

  @override
  State<AdCampaignRoiBody> createState() => _AdCampaignRoiBodyState();
}

class _AdCampaignRoiBodyState extends State<AdCampaignRoiBody> {
  late List<AdCampaignEntity> _campaigns = widget.initialCampaigns;

  Future<void> _addCampaign() async {
    final campaign = await showAdCampaignDialog(context);
    if (campaign == null) return;
    AdCampaignRepository(Get.find<ObjectBox>().store.box<AdCampaignEntity>())
        .insert(campaign);
    setState(() => _campaigns = [..._campaigns, campaign]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeAdCampaignRoi.call(_campaigns, widget.transactions);
    return AdCampaignRoiView(results: results, onAddCampaign: _addCampaign);
  }
}
