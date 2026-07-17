import 'package:growth_pilot_ai/core/interfaces/accounting_export_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for the NestJS export worker (Issue #59). Emulates a
/// successful QBO/Xero push without a real backend or BullMQ queue; web-safe.
class MockAccountingExportService implements AccountingExportService {
  @override
  OmniResult<String> pushTransaction({
    required int transactionId,
    required String accountId,
  }) async {
    if (accountId.isEmpty) {
      return OmniResponse.error('Missing Chart-of-Accounts id', statusCode: 400);
    }
    final externalId = 'mock-ext-$transactionId';
    OmniLogger.info('Exported tx $transactionId -> $externalId');
    return OmniResponse.success(externalId, message: 'Pushed to accounting');
  }
}
