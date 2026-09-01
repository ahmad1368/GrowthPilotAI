import 'package:flutter/material.dart';

/// Fades and slides [child] in once, on first build (Issue #201 AC:
/// "Animated Entrance... when the chat opens") — this widget is only
/// ever inserted into the tree when the chat window opens, so "first
/// build" and "chat opens" coincide.
class AnimatedPromptEntrance extends StatelessWidget {
  final Widget child;
  const AnimatedPromptEntrance({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(offset: Offset(0, (1 - value) * 12), child: child),
      ),
      child: child,
    );
  }
}
