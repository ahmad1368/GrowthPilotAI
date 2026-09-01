import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/auto_review_kyc_submission.dart';
import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);
  final bytes = Uint8List.fromList([1]);

  test('verifies a submission with both documents present', () {
    final submission = KycVerificationEntity(
        userId: 'u1', idDocumentBytes: bytes, businessDocumentBytes: bytes)
      ..status = KycVerificationStatus.pending;

    AutoReviewKycSubmission.call(submission, now);

    expect(submission.status, KycVerificationStatus.verified);
    expect(submission.reviewedAt, now);
  });

  test('rejects a submission missing the business document', () {
    final submission = KycVerificationEntity(userId: 'u1', idDocumentBytes: bytes)
      ..status = KycVerificationStatus.pending;

    AutoReviewKycSubmission.call(submission, now);

    expect(submission.status, KycVerificationStatus.rejected);
    expect(submission.rejectionReason, isNotNull);
  });

  test('does nothing for a submission that is not pending', () {
    final submission = KycVerificationEntity(userId: 'u1')..status = KycVerificationStatus.verified;
    AutoReviewKycSubmission.call(submission, now);
    expect(submission.status, KycVerificationStatus.verified);
    expect(submission.reviewedAt, isNull);
  });
}
