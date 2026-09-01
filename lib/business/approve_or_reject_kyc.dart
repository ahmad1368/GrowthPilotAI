import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/review_kyc_submission.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/kyc_verification_repository.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:objectbox/objectbox.dart';

/// A moderator's KYC decision (Issue #151 "Auditability" AC): applies
/// [ReviewKycSubmission] and appends an entry to the shared #343 audit
/// trail in the same write transaction, so a decision is never persisted
/// without its audit record.
class ApproveOrRejectKyc {
  static OmniResult<KycVerificationEntity> call(
    Store store,
    String adminId,
    KycVerificationEntity submission, {
    required bool approve,
    String? rejectionReason,
    required DateTime now,
  }) async {
    ReviewKycSubmission.call(submission,
        approve: approve, rejectionReason: rejectionReason, now: now);

    try {
      store.runInTransaction(TxMode.write, () {
        KycVerificationRepository(store.box<KycVerificationEntity>()).upsert(submission);
        AuditLogRepository(store.box<AuditLogEntity>()).record(BuildAuditLogEntry.call(
          adminId: adminId,
          changeType: approve ? 'KYC_APPROVE' : 'KYC_REJECT',
          targetMerchant: submission.userId,
          newValue: submission.status.name,
          timestamp: now,
        ));
      });
      return OmniResponse.success(submission);
    } catch (e) {
      return OmniResponse.error(e.toString());
    }
  }
}
