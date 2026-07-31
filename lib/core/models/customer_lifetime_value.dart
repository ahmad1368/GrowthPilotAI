import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/customer_cohort.dart';

/// Projected Customer Lifetime Value for one buyer (Issue #394):
/// average purchase value x purchase frequency x projected lifespan.
@immutable
class CustomerLifetimeValue {
  final String label;
  final double averagePurchaseValue;
  final double purchaseFrequencyPerMonth;
  final double projectedLifespanMonths;
  final double lifetimeValue;
  final CustomerCohort cohort;

  const CustomerLifetimeValue({
    required this.label,
    required this.averagePurchaseValue,
    required this.purchaseFrequencyPerMonth,
    required this.projectedLifespanMonths,
    required this.lifetimeValue,
    required this.cohort,
  });
}
