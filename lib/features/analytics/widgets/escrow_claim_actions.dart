import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/file_escrow_claim.dart';
import 'package:growth_pilot_ai/business/resolve_escrow_dispute.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_repos.dart';

/// Refund-claim filing and admin dispute resolution (Issue #415,
/// acceptance criteria 3-5) — split out of [EscrowBody]. Evidence
/// submission for the dispute dossier lives in [EscrowEvidenceActions]
/// (Issue #427).
class EscrowClaimActions {
  final EscrowRepos repos;

  EscrowClaimActions(this.repos);

  EscrowAccountEntity fileClaim(EscrowAccountEntity account, EscrowClaimReason reason) {
    final updated = FileEscrowClaim.call(account, reason);
    repos.accounts.save(updated);
    final autoApproved = updated.status == EscrowStatus.refunded;
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: autoApproved ? 'auto-refunded escrow claim' : 'flagged escrow dispute',
      targetMerchant: account.sellerName,
      previousValue: 'held',
      newValue: '${reason.name} claim by ${account.buyerName}',
    ));
    return updated;
  }

  EscrowAccountEntity resolveDispute(EscrowAccountEntity account, {required bool approveRefund}) {
    final updated = ResolveEscrowDispute.call(account, approveRefund: approveRefund);
    repos.accounts.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'resolved escrow dispute',
      targetMerchant: account.sellerName,
      previousValue: 'disputed',
      newValue: approveRefund ? 'refunded' : 'released',
    ));
    return updated;
  }
}
