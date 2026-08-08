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

  /// Pushes a finalized Tax Invoice (#146) to the accounting provider,
  /// mapped to a Chart-of-Accounts [accountId] (Issue #149).
  OmniResult<String> pushInvoice({
    required int invoiceId,
    required String accountId,
  });

  /// Records the invoice's Payment Status (#147) against the
  /// provider's own invoice record.
  OmniResult<void> pushPayment({
    required int paymentId,
    required String externalInvoiceId,
  });
}
