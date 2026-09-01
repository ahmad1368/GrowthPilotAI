import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_price_trend_points.dart';
import 'package:growth_pilot_ai/business/classify_price_deal.dart';
import 'package:growth_pilot_ai/business/compute_fair_price_index.dart';
import 'package:growth_pilot_ai/business/compute_regional_price_baseline.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_intelligence_result.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_query_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_query_fields.dart';

/// Owns the SKU price-check query and its computed Fair Price Index
/// result (Issue #416) — queries run synchronously against the
/// already-loaded [observations] list, satisfying the low-latency
/// acceptance criterion 5 with no network round-trip.
class PriceIntelligenceBody extends StatefulWidget {
  final List<CompetitorPriceObservationEntity> observations;
  const PriceIntelligenceBody({super.key, required this.observations});
  @override
  State<PriceIntelligenceBody> createState() => _PriceIntelligenceBodyState();
}

class _PriceIntelligenceBodyState extends State<PriceIntelligenceBody> {
  final _query = PriceQueryController();
  String? _checkedProduct;

  void _check() {
    if (!_query.isValid) return;
    setState(() => _checkedProduct = _query.productName.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final product = _checkedProduct;
    Widget? result;
    if (product != null) {
      final baseline = ComputeRegionalPriceBaseline.call(product, widget.observations);
      final candidate = double.tryParse(_query.candidatePrice.text) ?? 0;
      final fpi = ComputeFairPriceIndex.call(candidate, baseline.averagePrice);
      result = PriceIntelligenceResult(
        averagePrice: baseline.averagePrice,
        sampleCount: baseline.sampleCount,
        fairPriceIndex: fpi,
        tier: ClassifyPriceDeal.call(fpi),
        trendPoints: BuildPriceTrendPoints.call(product, widget.observations),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PriceQueryFields(query: _query, onCheck: _check),
        if (result != null) result,
      ],
    );
  }
}
