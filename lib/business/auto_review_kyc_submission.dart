import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

/// "Successful ... automated review" (Issue #144) — this app has no real
/// ID-verification AI or human moderator queue, so review is simulated
/// by a minimal completeness check (both documents present) rather than
/// an always-true rubber stamp.
class AutoReviewKycSubmission {
  static void call(KycVerificationEntity submission, DateTime now) {
    if (submission.status != KycVerificationStatus.pending) return;

    if (submission.idDocumentBytes == null || submission.businessDocumentBytes == null) {
      submission.status = KycVerificationStatus.rejected;
      submission.rejectionReason = 'Missing required identification or business document.';
    } else {
      submission.status = KycVerificationStatus.verified;
      submission.rejectionReason = null;
    }
    submission.reviewedAt = now;
  }
}
