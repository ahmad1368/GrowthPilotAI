import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_exchange_rate_impacts.dart';
import 'package:growth_pilot_ai/core/data/entities/exchange_rate_observation_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/exchange_rate_observation_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/exchange_rate_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/exchange_rate_view.dart';

/// Owns the logged-observation list (Issue #371), refreshing it locally
/// after each quick-add insert — mirrors [CompetitorPriceBody]'s pattern.
class ExchangeRateBody extends StatefulWidget {
  final List<ExchangeRateObservationEntity> initialObservations;

  const ExchangeRateBody({super.key, required this.initialObservations});

  @override
  State<ExchangeRateBody> createState() => _ExchangeRateBodyState();
}

class _ExchangeRateBodyState extends State<ExchangeRateBody> {
  late List<ExchangeRateObservationEntity> _observations =
      widget.initialObservations;

  Future<void> _addObservation() async {
    final observation = await showExchangeRateDialog(context);
    if (observation == null) return;
    ExchangeRateObservationRepository(
            Get.find<ObjectBox>().store.box<ExchangeRateObservationEntity>())
        .insert(observation);
    setState(() => _observations = [..._observations, observation]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeExchangeRateImpacts.call(_observations);
    return ExchangeRateView(results: results, onAddObservation: _addObservation);
  }
}
