import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/beta_feedback_fab.dart';

/// Wraps the whole app so the beta feedback button (Issue #169) stays
/// available over every screen without any of them needing to know
/// about it, mirroring this repo's existing #200 `AiChatRootOverlay`
/// pattern. Placed bottom-left so it doesn't collide with the AI
/// chat FAB (bottom-right).
class BetaFeedbackRootOverlay extends StatelessWidget {
  final Widget child;
  const BetaFeedbackRootOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      const Positioned(left: 16, bottom: 16, child: BetaFeedbackFab()),
    ]);
  }
}
