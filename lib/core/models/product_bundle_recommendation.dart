import 'package:flutter/foundation.dart';

/// A frequently co-purchased item pair with a suggested bundle price
/// (Issue #378) — [combinedBasePrice] uses each item's [unitCost] as a
/// price stand-in, since this app has no separate retail-price field.
@immutable
class ProductBundleRecommendation {
  final String itemA;
  final String itemB;
  final int coOccurrenceCount;
  final double supportRatio;
  final double combinedBasePrice;
  final double suggestedBundlePrice;
  final double discountAmount;

  const ProductBundleRecommendation({
    required this.itemA,
    required this.itemB,
    required this.coOccurrenceCount,
    required this.supportRatio,
    required this.combinedBasePrice,
    required this.suggestedBundlePrice,
    required this.discountAmount,
  });
}
