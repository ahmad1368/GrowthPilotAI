import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/approve_or_reject_kyc.dart';
import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/kyc_verification_repository.dart';

/// Drives the moderator "KYC Approval Queue" (Issue #151 scope item 2).
class KycAdminReviewController extends GetxController {
  late KycVerificationRepository _repo;
  final pending = <KycVerificationEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _repo = KycVerificationRepository(Get.find<ObjectBox>().store.box());
  }

  void loadQueue() => pending.assignAll(_repo.getPending());

  Future<void> decide(
    String adminId,
    KycVerificationEntity submission, {
    required bool approve,
    String? rejectionReason,
  }) async {
    await ApproveOrRejectKyc.call(
      Get.find<ObjectBox>().store,
      adminId,
      submission,
      approve: approve,
      rejectionReason: rejectionReason,
      now: DateTime.now(),
    );
    loadQueue();
  }
}
