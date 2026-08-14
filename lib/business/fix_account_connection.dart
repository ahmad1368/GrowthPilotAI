import 'package:growth_pilot_ai/core/interfaces/bank_link_service.dart';

/// Re-runs the Plaid Link mock chain (Issue #61) to clear a sub-account's
/// `ITEM_LOGIN_REQUIRED` state (Issue #68's "Fix Connection" action).
class FixAccountConnection {
  final BankLinkService bank;

  FixAccountConnection(this.bank);

  Future<bool> call() async {
    final tokenRes = await bank.createLinkToken();
    if (!tokenRes.success) return false;
    final publicTokenRes = await bank.openLink(tokenRes.data!);
    if (!publicTokenRes.success) return false;
    final accountRes = await bank.exchangePublicToken(publicTokenRes.data!);
    return accountRes.success;
  }
}
