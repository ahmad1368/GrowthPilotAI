import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';

/// One-sentence readout of a dispute's evidence dossier (Issue #427,
/// acceptance criterion 5) — surfaced to the admin before they rule
/// on a disputed escrow account.
class BuildDisputeDossierSummary {
  static String call(List<DisputeEvidenceEntity> evidence) {
    if (evidence.isEmpty) return 'No evidence submitted yet.';
    final submitters = evidence.map((e) => e.submittedBy).toSet();
    return '${evidence.length} evidence item(s) submitted by ${submitters.join(', ')}.';
  }
}
