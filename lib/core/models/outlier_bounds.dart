import 'package:flutter/foundation.dart';

/// The IQR "fences" from [ComputeOutlierBounds] (Issue #98) — a value
/// outside [lowerBound]/[upperBound] is flagged as an outlier.
@immutable
class OutlierBounds {
  final double lowerBound;
  final double upperBound;

  const OutlierBounds({required this.lowerBound, required this.upperBound});

  bool isOutlier(double value) => value < lowerBound || value > upperBound;
}
