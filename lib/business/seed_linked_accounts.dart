import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';

/// Demo sub-accounts shown the first time the Connected Accounts screen
/// opens (Issue #68) — stands in for a real Plaid `/accounts/get` response
/// since no backend exists in this repo yet.
class SeedLinkedAccounts {
  static List<LinkedAccountEntity> call(List<LinkedAccountEntity> existing) {
    if (existing.isNotEmpty) return [];
    return [
      LinkedAccountEntity(
        accountId: 'td-chequing-01',
        institutionName: 'TD Canada Trust',
        officialName: 'TD Business Chequing',
        mask: '4521',
        accountType: 'depository',
        currentBalance: 12480.55,
      ),
      LinkedAccountEntity(
        accountId: 'td-credit-01',
        institutionName: 'TD Canada Trust',
        officialName: 'TD Business Travel Visa',
        mask: '7788',
        accountType: 'credit',
        currentBalance: -1345.20,
      ),
      LinkedAccountEntity(
        accountId: 'scotia-savings-01',
        institutionName: 'Scotiabank',
        officialName: 'Scotia Personal Savings',
        mask: '0932',
        accountType: 'depository',
        currentBalance: 6200.00,
        isActive: false,
      ),
      LinkedAccountEntity(
        accountId: 'scotia-credit-01',
        institutionName: 'Scotiabank',
        officialName: 'Scotia Business Mastercard',
        mask: '3310',
        accountType: 'credit',
        currentBalance: -430.00,
        needsReauth: true,
      ),
    ];
  }
}
