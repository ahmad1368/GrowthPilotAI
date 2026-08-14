import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_dispute_dossier_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';

DisputeEvidenceEntity _evidence(String submittedBy) {
  return DisputeEvidenceEntity(
    escrowAccountId: 1,
    submittedBy: submittedBy,
    description: 'note',
    submittedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('reports no evidence when the dossier is empty', () {
    expect(BuildDisputeDossierSummary.call([]), 'No evidence submitted yet.');
  });

  test('counts items and lists distinct submitters', () {
    final summary = BuildDisputeDossierSummary.call([_evidence('Alpha'), _evidence('Beta')]);
    expect(summary, contains('2 evidence item(s)'));
    expect(summary, contains('Alpha'));
    expect(summary, contains('Beta'));
  });
}
