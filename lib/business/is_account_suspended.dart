import 'package:growth_pilot_ai/core/models/account_suspension_status.dart';

/// Whether a merchant's transactional access should currently be
/// blocked (Issue #341, acceptance criterion 2) — any transactional
/// screen/dialog for a merchant can call this before allowing the
/// action, mirroring [CheckModuleRouteAccess]'s reusable-guard pattern.
class IsAccountSuspended {
  static bool call(List<AccountSuspensionStatus> statuses, String merchantName) {
    final match = statuses.where((s) => s.merchantName == merchantName);
    if (match.isEmpty) return false;
    return match.first.isActive;
  }
}
