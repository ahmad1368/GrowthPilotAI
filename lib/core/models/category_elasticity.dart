import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/spending_trend.dart';

/// Historical price-vs-volume correlation hint for one category (Issue
/// #380): [ElasticityHint.elastic] when a rising average price coincided
/// with falling booking volume, [ElasticityHint.inelastic] when volume
/// held up despite rising price.
enum ElasticityHint { elastic, inelastic, insufficient }

@immutable
class CategoryElasticity {
  final String categoryName;
  final double averagePrice;
  final SpendingTrend priceTrend;
  final SpendingTrend volumeTrend;
  final ElasticityHint hint;

  const CategoryElasticity({
    required this.categoryName,
    required this.averagePrice,
    required this.priceTrend,
    required this.volumeTrend,
    required this.hint,
  });
}
