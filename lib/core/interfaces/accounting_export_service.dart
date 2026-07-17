import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Contract for pushing one confirmed transaction to QuickBooks/Xero
/// (Issue #59). A real implementation would call the QBO createExpense or
/// Xero /BankTransactions endpoint; callers stay decoupled from which
/// provider is active. Resolves to the provider's external record id.
abstract class AccountingExportService {
  OmniResult<String> pushTransaction({
    required int transactionId,
    required String accountId,
  });
}
