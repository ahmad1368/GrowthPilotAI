import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/submit_dispute_evidence.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';

void main() {
  test('builds an evidence entry with the given fields', () {
    final now = DateTime(2026, 1, 1);
    final evidence = SubmitDisputeEvidence.call(
      escrowAccountId: 5,
      submittedBy: 'Alpha',
      type: DisputeEvidenceType.photo,
      description: 'Photo of damaged item',
      now: now,
    );
    expect(evidence.escrowAccountId, 5);
    expect(evidence.submittedBy, 'Alpha');
    expect(evidence.evidenceType, DisputeEvidenceType.photo);
    expect(evidence.description, 'Photo of damaged item');
    expect(evidence.submittedAt, now);
  });
}
