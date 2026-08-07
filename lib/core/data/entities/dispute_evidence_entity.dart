import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';

/// One piece of evidence submitted by either party while an
/// [EscrowAccountEntity] is disputed (Issue #427, acceptance criteria
/// 2 and 5) — an append-only dossier entry, never edited or deleted,
/// so the admin's arbitration record stays unalterable.
@Entity()
class DisputeEvidenceEntity {
  @Id()
  int id = 0;

  @Index()
  int escrowAccountId;

  String submittedBy;
  int dbEvidenceType;
  String description;

  @Index()
  @Property(type: PropertyType.date)
  DateTime submittedAt;

  DisputeEvidenceEntity({
    this.id = 0,
    required this.escrowAccountId,
    required this.submittedBy,
    this.dbEvidenceType = 0,
    required this.description,
    required this.submittedAt,
  });

  DisputeEvidenceType get evidenceType => DisputeEvidenceType.values[dbEvidenceType];
  set evidenceType(DisputeEvidenceType value) => dbEvidenceType = value.index;
}
