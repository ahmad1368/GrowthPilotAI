import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/floating_fab_layout.dart';
import 'package:growth_pilot_ai/widgets/beta_feedback_fab.dart';

/// Wraps the whole app so the beta feedback button (Issue #169) stays
/// available over every screen without any of them needing to know
/// about it, mirroring this repo's existing #200 `AiChatRootOverlay`
/// pattern.
///
/// [Issue #823] Was bottom-left, opposite the AI chat FAB. Now stacked
/// directly above the chat FAB in the same bottom-right column, per the
/// shared offsets in [FloatingFabLayout].
class BetaFeedbackRootOverlay extends StatelessWidget {
  final Widget child;
  const BetaFeedbackRootOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      const Positioned(
          right: 16,
          bottom: FloatingFabLayout.feedbackFabBottom,
          child: BetaFeedbackFab()),
    ]);
  }
}
