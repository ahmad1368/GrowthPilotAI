import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_competitor_price_gaps.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/competitor_price_observation_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_price_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_price_view.dart';

/// Owns the logged-observation list (Issue #351), refreshing it locally
/// after each quick-add insert — mirrors [DiscountCampaignImpactBody]'s
/// pattern.
class CompetitorPriceBody extends StatefulWidget {
  final List<CompetitorPriceObservationEntity> initialObservations;

  const CompetitorPriceBody({super.key, required this.initialObservations});

  @override
  State<CompetitorPriceBody> createState() => _CompetitorPriceBodyState();
}

class _CompetitorPriceBodyState extends State<CompetitorPriceBody> {
  late List<CompetitorPriceObservationEntity> _observations =
      widget.initialObservations;

  Future<void> _addObservation() async {
    final observation = await showCompetitorPriceDialog(context);
    if (observation == null) return;
    CompetitorPriceObservationRepository(
            Get.find<ObjectBox>().store.box<CompetitorPriceObservationEntity>())
        .insert(observation);
    setState(() => _observations = [..._observations, observation]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeCompetitorPriceGaps.call(_observations);
    return CompetitorPriceView(
        results: results, onAddObservation: _addObservation);
  }
}
