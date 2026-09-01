import 'package:growth_pilot_ai/core/models/outlier_bounds.dart';

/// The IQR method (Issue #98 scope item 1): fences at
/// `Q1 - multiplier*IQR` / `Q3 + multiplier*IQR`, mirroring the issue's
/// own `calculateOutlierBounds`. [iqrMultiplier] is configurable per the
/// "Sensitivity" technical constraint (1.5 is the classic default).
/// Under 4 values there isn't enough data for quartiles, so nothing is
/// flagged.
class ComputeOutlierBounds {
  static OutlierBounds call(List<double> values, {double iqrMultiplier = 1.5}) {
    if (values.length < 4) {
      return const OutlierBounds(lowerBound: 0, upperBound: double.infinity);
    }

    final sorted = List<double>.of(values)..sort();
    final q1 = sorted[(sorted.length * 0.25).floor()];
    final q3 = sorted[(sorted.length * 0.75).floor()];
    final iqr = q3 - q1;

    return OutlierBounds(
      lowerBound: q1 - iqrMultiplier * iqr,
      upperBound: q3 + iqrMultiplier * iqr,
    );
  }
}
