import 'package:flutter/foundation.dart';

/// One plotted point on the Fair Price Index trend chart (Issue
/// #416, acceptance criterion 4): an observed regional price at a
/// point in time, mirroring [ProfitMarginPoint]'s shape.
@immutable
class PriceTrendPoint {
  final DateTime observedAt;
  final double price;

  const PriceTrendPoint({required this.observedAt, required this.price});
}
