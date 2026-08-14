import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/submit_dispute_evidence.dart';
import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_repos.dart';

/// Dispute-evidence submission for the admin dossier (Issue #427,
/// acceptance criteria 2 and 5) — split out of [EscrowClaimActions].
class EscrowEvidenceActions {
  final EscrowRepos repos;

  EscrowEvidenceActions(this.repos);

  DisputeEvidenceEntity submit(
    EscrowAccountEntity account,
    String submittedBy,
    DisputeEvidenceType type,
    String description,
  ) {
    final evidence = SubmitDisputeEvidence.call(
      escrowAccountId: account.id,
      submittedBy: submittedBy,
      type: type,
      description: description,
      now: DateTime.now(),
    );
    repos.evidence.record(evidence);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'submitted dispute evidence',
      targetMerchant: account.sellerName,
      newValue: '${type.name} from $submittedBy',
    ));
    return evidence;
  }
}
