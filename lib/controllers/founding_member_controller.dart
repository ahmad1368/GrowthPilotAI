import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/claim_founding_member_spot.dart';
import 'package:growth_pilot_ai/core/data/entities/beta_feedback_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/founding_member_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/beta_feedback_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/founding_member_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/subscription_repository.dart';

/// Drives the "Founding Member" Beta Program (Issue #191) — claiming a
/// spot (first 100, local-only count; see PR notes), the "Spots
/// Remaining" counter, and beta feedback submission.
class FoundingMemberController extends GetxController {
  late FoundingMemberRepository _founding;
  late BetaFeedbackRepository _feedback;
  late SubscriptionRepository _subscriptions;

  final spotsRemaining = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _founding = FoundingMemberRepository(store.box(), store.box());
    _feedback = BetaFeedbackRepository(store.box());
    _subscriptions = SubscriptionRepository(store.box());
    _refreshSpotsRemaining();
  }

  void _refreshSpotsRemaining() {
    final counter = _founding.getCounter();
    spotsRemaining.value = (counter.capacity - counter.claimedCount).clamp(0, counter.capacity);
  }

  FoundingMemberEntity? claimSpot(String businessId) {
    final spot = ClaimFoundingMemberSpot.call(
      foundingRepo: _founding,
      subscriptionRepo: _subscriptions,
      businessId: businessId,
      now: DateTime.now(),
    );
    _refreshSpotsRemaining();
    return spot;
  }

  FoundingMemberEntity? spotFor(String businessId) => _founding.getForBusiness(businessId);

  void submitFeedback({
    required String businessId,
    required int rating,
    required String comment,
    required String appVersion,
  }) {
    _feedback.append(BetaFeedbackEntity(
      businessId: businessId,
      rating: rating,
      comment: comment,
      appVersion: appVersion,
      submittedAt: DateTime.now(),
    ));
  }
}
