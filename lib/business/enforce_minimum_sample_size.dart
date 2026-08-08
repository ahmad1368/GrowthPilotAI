import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

/// "Minimum Sample Size" ethics guard (Issue #148 AC): a trend is only
/// shown once at least 5 distinct businesses contributed to it, to
/// prevent a single competitor's activity from leaking through.
class EnforceMinimumSampleSize {
  static const minDistinctBusinesses = 5;

  static bool call(List<ProcurementRequestEntity> requests) =>
      requests.map((r) => r.requesterId).toSet().length >= minDistinctBusinesses;
}
