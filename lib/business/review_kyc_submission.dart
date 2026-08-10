import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

/// Applies a human moderator's decision to a pending KYC submission (Issue
/// #151 scope item 2: "KYC Approval Queue") — [AutoReviewKycSubmission]
/// (#144) is a completeness rubber-stamp; this is the manual override a
/// moderator makes for cases needing human judgment. Mutates in place,
/// same shape as [AutoReviewKycSubmission].
class ReviewKycSubmission {
  static void call(
    KycVerificationEntity submission, {
    required bool approve,
    String? rejectionReason,
    required DateTime now,
  }) {
    if (submission.status != KycVerificationStatus.pending) return;

    submission.status =
        approve ? KycVerificationStatus.verified : KycVerificationStatus.rejected;
    submission.rejectionReason = approve ? null : (rejectionReason ?? 'Rejected by moderator.');
    submission.reviewedAt = now;
  }
}
