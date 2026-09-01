import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/review_kyc_submission.dart';
import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('approving a pending submission verifies it', () {
    final submission = KycVerificationEntity(userId: 'u1')
      ..status = KycVerificationStatus.pending;

    ReviewKycSubmission.call(submission, approve: true, now: now);

    expect(submission.status, KycVerificationStatus.verified);
    expect(submission.rejectionReason, isNull);
    expect(submission.reviewedAt, now);
  });

  test('rejecting a pending submission uses the given reason', () {
    final submission = KycVerificationEntity(userId: 'u1')
      ..status = KycVerificationStatus.pending;

    ReviewKycSubmission.call(submission,
        approve: false, rejectionReason: 'Blurry ID photo.', now: now);

    expect(submission.status, KycVerificationStatus.rejected);
    expect(submission.rejectionReason, 'Blurry ID photo.');
  });

  test('rejecting without a reason falls back to a default message', () {
    final submission = KycVerificationEntity(userId: 'u1')
      ..status = KycVerificationStatus.pending;

    ReviewKycSubmission.call(submission, approve: false, now: now);

    expect(submission.rejectionReason, isNotNull);
  });

  test('does nothing for a submission that is not pending', () {
    final submission = KycVerificationEntity(userId: 'u1')
      ..status = KycVerificationStatus.verified;

    ReviewKycSubmission.call(submission, approve: false, now: now);

    expect(submission.status, KycVerificationStatus.verified);
    expect(submission.reviewedAt, isNull);
  });
}
