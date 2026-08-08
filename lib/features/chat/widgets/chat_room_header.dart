import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Room title + online-dot presence (Issue #123/#136 AC). [onToggleOnline]
/// exposes the local online/offline simulation (#122) since there is no
/// second device to flip it from.
class ChatRoomHeader extends StatelessWidget {
  final String otherUserId;
  final bool isOnline;
  final VoidCallback onToggleOnline;

  const ChatRoomHeader({
    super.key,
    required this.otherUserId,
    required this.isOnline,
    required this.onToggleOnline,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: isOnline ? Colors.green : colors.mutedForeground),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(otherUserId, style: const TextStyle(fontWeight: FontWeight.w600))),
        ShadButton.ghost(
            onPressed: onToggleOnline,
            child: Text(isOnline ? 'Online' : 'Offline', style: const TextStyle(fontSize: 11))),
      ]),
    );
  }
}
