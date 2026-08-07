import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';

/// Builds one dossier entry for a disputed escrow account (Issue
/// #427, acceptance criteria 2 and 5).
class SubmitDisputeEvidence {
  static DisputeEvidenceEntity call({
    required int escrowAccountId,
    required String submittedBy,
    required DisputeEvidenceType type,
    required String description,
    required DateTime now,
  }) {
    final evidence = DisputeEvidenceEntity(
      escrowAccountId: escrowAccountId,
      submittedBy: submittedBy,
      description: description,
      submittedAt: now,
    );
    evidence.evidenceType = type;
    return evidence;
  }
}
