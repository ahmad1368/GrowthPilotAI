import 'dart:typed_data';

import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

/// "Document Submission" (Issue #144): moves an existing (or brand new)
/// [KycVerificationEntity] into PENDING with the freshly uploaded docs.
class SubmitKycVerification {
  static KycVerificationEntity call({
    required KycVerificationEntity? existing,
    required String userId,
    required Uint8List idDocumentBytes,
    required Uint8List businessDocumentBytes,
    required DateTime now,
  }) {
    final entity = existing ?? KycVerificationEntity(userId: userId);
    entity.status = KycVerificationStatus.pending;
    entity.idDocumentBytes = idDocumentBytes;
    entity.businessDocumentBytes = businessDocumentBytes;
    entity.rejectionReason = null;
    entity.submittedAt = now;
    entity.reviewedAt = null;
    return entity;
  }
}
