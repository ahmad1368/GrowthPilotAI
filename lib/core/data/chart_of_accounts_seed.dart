import 'package:growth_pilot_ai/core/models/chart_of_account.dart';

/// Placeholder Chart of Accounts until the QuickBooks/Xero COA sync service
/// ships (out of scope for Issue #58 — no accounting backend in this repo
/// yet). Gives [AccountFuzzyMatcher] real-looking targets to match against.
class ChartOfAccountsSeed {
  static const List<ChartOfAccount> accounts = [
    ChartOfAccount(
        accountId: '6100', accountName: 'Travel Expense', accountType: 'Expense'),
    ChartOfAccount(
        accountId: '6200', accountName: 'Office Supplies', accountType: 'Expense'),
    ChartOfAccount(
        accountId: '6300', accountName: 'Meals & Entertainment', accountType: 'Expense'),
    ChartOfAccount(
        accountId: '6400', accountName: 'Software & Subscriptions', accountType: 'Expense'),
    ChartOfAccount(
        accountId: '6500', accountName: 'Marketing & Advertising', accountType: 'Expense'),
    ChartOfAccount(
        accountId: '6600', accountName: 'Utilities', accountType: 'Expense'),
    ChartOfAccount(
        accountId: '6700', accountName: 'Professional Fees', accountType: 'Expense'),
    ChartOfAccount(
        accountId: '4000', accountName: 'Sales Revenue', accountType: 'Income'),
  ];
}
