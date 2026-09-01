import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/submit_kyc_verification.dart';
import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);
  final bytes = Uint8List.fromList([1, 2, 3]);

  test('creates a new pending submission when none exists', () {
    final result = SubmitKycVerification.call(
        existing: null, userId: 'u1', idDocumentBytes: bytes, businessDocumentBytes: bytes, now: now);

    expect(result.userId, 'u1');
    expect(result.status, KycVerificationStatus.pending);
    expect(result.submittedAt, now);
  });

  test('resubmitting clears a prior rejection', () {
    final existing = KycVerificationEntity(userId: 'u1')
      ..status = KycVerificationStatus.rejected
      ..rejectionReason = 'blurry photo';

    final result = SubmitKycVerification.call(
        existing: existing, userId: 'u1', idDocumentBytes: bytes, businessDocumentBytes: bytes, now: now);

    expect(identical(result, existing), isTrue);
    expect(result.status, KycVerificationStatus.pending);
    expect(result.rejectionReason, isNull);
  });
}
