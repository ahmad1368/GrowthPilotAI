import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/cap_expansion_status.dart';

/// Applies an admin's approve/deny decision to a pending cap expansion
/// request (Issue #344, acceptance criterion 3) — pure construction,
/// the caller persists the result and, on approval, raises the daily
/// cap to [CapExpansionRequestEntity.requestedCapAmount].
class ApplyCapExpansionDecision {
  static CapExpansionRequestEntity call(CapExpansionRequestEntity request, bool approved) {
    return CapExpansionRequestEntity(
      id: request.id,
      requestedCapAmount: request.requestedCapAmount,
      reason: request.reason,
      dbStatus: (approved ? CapExpansionStatus.approved : CapExpansionStatus.denied).index,
      requestedAt: request.requestedAt,
    );
  }
}
