import 'package:growth_pilot_ai/core/data/entities/business_rating_entity.dart';

/// The single-review average `R` across the "Multi-Dimensional Metrics"
/// sub-scores (Issue #125), fed into the Bayesian weighted formula.
class ComputeBusinessRatingAverage {
  static double call(BusinessRatingEntity rating) =>
      (rating.punctuality + rating.accuracy + rating.communication) / 3;
}
