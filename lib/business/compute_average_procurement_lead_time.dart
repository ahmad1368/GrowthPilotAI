import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';

/// "Average Procurement Lead Time" (Issue #129) — average time from a
/// request's broadcast to its first provider response, across every
/// request that received at least one.
class ComputeAverageProcurementLeadTime {
  static Duration call(
      List<ProcurementRequestEntity> requests, List<ProcurementResponseEntity> responses) {
    final leadTimes = <Duration>[];
    for (final request in requests) {
      final forRequest = responses.where((r) => r.requestId == request.id).toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      if (forRequest.isEmpty) continue;
      leadTimes.add(forRequest.first.createdAt.difference(request.createdAt));
    }
    if (leadTimes.isEmpty) return Duration.zero;
    final totalMs = leadTimes.fold<int>(0, (sum, d) => sum + d.inMilliseconds);
    return Duration(milliseconds: totalMs ~/ leadTimes.length);
  }
}
