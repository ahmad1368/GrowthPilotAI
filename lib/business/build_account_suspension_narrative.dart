import 'package:growth_pilot_ai/core/models/account_suspension_status.dart';

/// One-sentence read naming how many merchants are actively suspended
/// (Issue #341).
class BuildAccountSuspensionNarrative {
  static String call(List<AccountSuspensionStatus> results) {
    if (results.isEmpty) {
      return 'No suspensions logged yet — suspend a merchant to start enforcing a timeframe.';
    }
    final active = results.where((r) => r.isActive);
    if (active.isEmpty) {
      return 'No merchants are currently suspended out of ${results.length} logged.';
    }
    final latest = active.first;
    return '${active.length} of ${results.length} merchant(s) are actively suspended — most '
        'recently "${latest.merchantName}" ("${latest.reason}") until ${latest.expiresAt}.';
  }
}
