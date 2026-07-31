import 'package:flutter/foundation.dart';

/// New-customer acquisition and retention around one statutory holiday
/// window (Issue #382).
@immutable
class SeasonalAcquisitionImpact {
  final String holidayName;
  final int newCustomersAcquired;
  final int retainedCustomers;
  final double retentionRate;

  const SeasonalAcquisitionImpact({
    required this.holidayName,
    required this.newCustomersAcquired,
    required this.retainedCustomers,
    required this.retentionRate,
  });
}
