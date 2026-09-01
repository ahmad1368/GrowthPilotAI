import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_discount_campaign_impact.dart';
import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/discount_campaign_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/discount_campaign_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/discount_campaign_impact_view.dart';

/// Owns the logged-campaign list (Issue #362), refreshing it locally
/// after each quick-add insert — mirrors [AdCampaignRoiBody]'s pattern.
class DiscountCampaignImpactBody extends StatefulWidget {
  final List<DiscountCampaignEntity> initialCampaigns;
  final List<TransactionEntity> transactions;

  const DiscountCampaignImpactBody(
      {super.key, required this.initialCampaigns, required this.transactions});

  @override
  State<DiscountCampaignImpactBody> createState() =>
      _DiscountCampaignImpactBodyState();
}

class _DiscountCampaignImpactBodyState extends State<DiscountCampaignImpactBody> {
  late List<DiscountCampaignEntity> _campaigns = widget.initialCampaigns;

  Future<void> _addCampaign() async {
    final campaign = await showDiscountCampaignDialog(context);
    if (campaign == null) return;
    DiscountCampaignRepository(
            Get.find<ObjectBox>().store.box<DiscountCampaignEntity>())
        .insert(campaign);
    setState(() => _campaigns = [..._campaigns, campaign]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeDiscountCampaignImpact.call(_campaigns, widget.transactions);
    return DiscountCampaignImpactView(results: results, onAddCampaign: _addCampaign);
  }
}
