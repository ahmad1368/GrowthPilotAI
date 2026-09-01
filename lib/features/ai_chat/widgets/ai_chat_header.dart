import 'package:flutter/material.dart';

/// Drag handle + minimize/close controls (Issue #200 AC: "A 'Minimize'
/// gesture (swipe down) is implemented to hide the chat while keeping
/// the session active").
class AiChatHeader extends StatelessWidget {
  final VoidCallback onMinimize;
  final VoidCallback onClose;
  const AiChatHeader({super.key, required this.onMinimize, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 200) onMinimize();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Financial Assistant', style: TextStyle(fontWeight: FontWeight.bold)),
          Row(children: [
            IconButton(
                icon: const Icon(Icons.remove_rounded), onPressed: onMinimize, tooltip: 'Minimize'),
            IconButton(icon: const Icon(Icons.close_rounded), onPressed: onClose, tooltip: 'Close'),
          ]),
        ]),
      ),
    );
  }
}
