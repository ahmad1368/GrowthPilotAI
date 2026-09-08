import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/founding_member_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/beta_feedback_form.dart';

/// Floating "Feedback" button (Issue #169), reachable from any screen via
/// [BetaFeedbackRootOverlay].
///
/// [Issue #829] Used to hide entirely unless the local user already held
/// a Founding Member spot — on a fresh install, or after any full app-data
/// reset, that record doesn't exist yet, so the icon silently vanished
/// with no placeholder or explanation, breaking the fixed floating-icon
/// stack this app deliberately keeps. Submission itself was never gated
/// on Founding Member status (only a daily rate limit, still enforced
/// below) — only visibility was, so this always renders now.
class BetaFeedbackFab extends StatelessWidget {
  const BetaFeedbackFab({super.key});

  static const _businessId = 'local-user';

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoundingMemberController>();
    return FloatingActionButton.small(
      heroTag: 'betaFeedbackFab',
      onPressed: () => _openSheet(context, controller),
      child: const Icon(Icons.feedback_outlined),
    );
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
