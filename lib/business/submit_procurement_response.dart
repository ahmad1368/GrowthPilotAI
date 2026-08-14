import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';

/// "Bid/Response Flow" (Issue #126): a provider's Quick Quote
/// ([quoteAmount] set) or Request for More Info ([quoteAmount] null).
class SubmitProcurementResponse {
  static ProcurementResponseEntity call({
    required int requestId,
    required String providerId,
    required String message,
    double? quoteAmount,
    required DateTime now,
  }) {
    return ProcurementResponseEntity(
      requestId: requestId,
      providerId: providerId,
      quoteAmount: quoteAmount,
      message: message,
      createdAt: now,
    );
  }
}
