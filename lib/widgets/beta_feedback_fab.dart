import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/founding_member_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/beta_feedback_form.dart';

/// Floating "Feedback" button visible only to Founding Members/beta
/// testers (Issue #169 AC: "widget is only visible to users with the
/// BETA_TESTER flag" — this app has no separate role/flag system, so
/// Founding Member status stands in; see PR notes), reachable from
/// any screen via [BetaFeedbackRootOverlay].
class BetaFeedbackFab extends StatelessWidget {
  const BetaFeedbackFab({super.key});

  static const _businessId = 'local-user';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoundingMemberController>();
    return Obx(() {
      controller.spotsRemaining.value; // re-check membership whenever a spot is claimed
      if (controller.spotFor(_businessId) == null) return const SizedBox.shrink();
      return FloatingActionButton.small(
        heroTag: 'betaFeedbackFab',
        onPressed: () => _openSheet(context, controller),
        child: const Icon(Icons.feedback_outlined),
      );
    });
  }

  void _openSheet(BuildContext context, FoundingMemberController controller) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Padding(
        padding: const EdgeInsets.all(16),
        child: BetaFeedbackForm(onSubmit: (rating, comment) {
          final saved = controller.submitFeedback(
            businessId: _businessId,
            rating: rating,
            comment: comment,
            appVersion: '1.0.8',
            routeName: Get.currentRoute,
          );
          Navigator.of(sheetContext).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(saved ? 'Thanks for the feedback!' : "You've reached today's feedback limit.")));
        }),
      ),
    );
  }
}
