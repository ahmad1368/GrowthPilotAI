import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/auto_review_kyc_submission.dart';
import 'package:growth_pilot_ai/business/submit_kyc_verification.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/kyc_verification_repository.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

/// Drives the KYC "Verification Center" (Issue #144).
class KycController extends GetxController {
  late KycVerificationRepository _repo;
  final status = KycVerificationStatus.none.obs;
  final rejectionReason = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    _repo = KycVerificationRepository(Get.find<ObjectBox>().store.box());
  }

  void loadFor(String userId) {
    final existing = _repo.getForUser(userId);
    status.value = existing?.status ?? KycVerificationStatus.none;
    rejectionReason.value = existing?.rejectionReason;
  }

  Future<void> submit(String userId, Uint8List idBytes, Uint8List businessBytes) async {
    final now = DateTime.now();
    final submission = SubmitKycVerification.call(
        existing: _repo.getForUser(userId),
        userId: userId,
        idDocumentBytes: idBytes,
        businessDocumentBytes: businessBytes,
        now: now);
    AutoReviewKycSubmission.call(submission, now);
    _repo.upsert(submission);
    status.value = submission.status;
    rejectionReason.value = submission.rejectionReason;
  }
}
