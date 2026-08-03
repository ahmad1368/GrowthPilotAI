import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_analytics_pricing_upgrades.dart';
import 'package:growth_pilot_ai/core/data/entities/analytics_pricing_tier_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/analytics_pricing_tier_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/analytics_pricing_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/analytics_pricing_view.dart';

/// Owns the logged pricing-tier list (Issue #336), refreshing it locally
/// after each quick-add insert — mirrors [PromotionalOfferBody]'s pattern.
class AnalyticsPricingBody extends StatefulWidget {
  final List<AnalyticsPricingTierEntity> initialTiers;

  const AnalyticsPricingBody({super.key, required this.initialTiers});

  @override
  State<AnalyticsPricingBody> createState() => _AnalyticsPricingBodyState();
}

class _AnalyticsPricingBodyState extends State<AnalyticsPricingBody> {
  late List<AnalyticsPricingTierEntity> _tiers = widget.initialTiers;

  Future<void> _addTier() async {
    final tier = await showAnalyticsPricingDialog(context);
    if (tier == null) return;
    AnalyticsPricingTierRepository(
            Get.find<ObjectBox>().store.box<AnalyticsPricingTierEntity>())
        .insert(tier);
    setState(() => _tiers = [..._tiers, tier]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeAnalyticsPricingUpgrades.call(_tiers);
    return AnalyticsPricingView(results: results, onAddTier: _addTier);
  }
}
