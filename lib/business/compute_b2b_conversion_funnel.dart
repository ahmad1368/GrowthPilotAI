import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

/// "B2B Conversion Funnel" (Issue #129): Broadcast -> Negotiating (has
/// at least one response) -> Matched (accepted).
class ComputeB2BConversionFunnel {
  static ({int broadcast, int negotiating, int matched}) call(
      List<ProcurementRequestEntity> requests, List<ProcurementResponseEntity> responses) {
    final respondedRequestIds = responses.map((r) => r.requestId).toSet();
    final negotiating = requests.where((r) => respondedRequestIds.contains(r.id)).length;
    final matched =
        requests.where((r) => r.status == ProcurementRequestStatus.accepted).length;
    return (broadcast: requests.length, negotiating: negotiating, matched: matched);
  }
}
