import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';

/// Builds a new pending cap expansion request (Issue #344, acceptance
/// criterion 3) — the merchant-side half of the review workflow.
class BuildCapExpansionRequest {
  static CapExpansionRequestEntity call({
    required double requestedCapAmount,
    required String reason,
    DateTime? requestedAt,
  }) {
    return CapExpansionRequestEntity(
      requestedCapAmount: requestedCapAmount,
      reason: reason,
      requestedAt: requestedAt ?? DateTime.now(),
    );
  }
}
