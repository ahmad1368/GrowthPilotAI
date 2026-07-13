/// Supported accounting integrations for the OAuth 2.0 connect flow.
enum AccountingProvider { quickbooks, xero }

extension AccountingProviderInfo on AccountingProvider {
  /// Minimal read-only scope requested per provider (token minimization).
  String get scope => this == AccountingProvider.quickbooks
      ? 'com.intuit.quickbooks.accounting'
      : 'accounting.transactions.read';

  String get label =>
      this == AccountingProvider.quickbooks ? 'QuickBooks' : 'Xero';
}
