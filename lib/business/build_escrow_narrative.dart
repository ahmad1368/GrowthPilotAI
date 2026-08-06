import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';

/// One-sentence read summarizing the escrow pipeline (Issue #415),
/// mirroring [BuildGroupPurchaseNarrative]'s summary pattern.
class BuildEscrowNarrative {
  static String call(List<EscrowAccountEntity> accounts) {
    if (accounts.isEmpty) {
      return 'No escrow accounts yet.';
    }
    final held = accounts.where((a) => a.status == EscrowStatus.held).length;
    final disputed = accounts.where((a) => a.status == EscrowStatus.disputed).length;
    return '${accounts.length} account(s): $held holding funds, $disputed awaiting admin arbitration.';
  }
}
