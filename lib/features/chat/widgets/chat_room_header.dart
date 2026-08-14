import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Room title + online-dot presence (Issue #123/#136 AC). [onToggleOnline]
/// exposes the local online/offline simulation (#122) since there is no
/// second device to flip it from. The overflow menu exposes Block/Report
/// (Issue #124/#134 "Privacy Settings menu... in the Chat Room" AC).
class ChatRoomHeader extends StatelessWidget {
  final String otherUserId;
  final bool isOnline;
  final VoidCallback onToggleOnline;
  final VoidCallback onBlock;
  final VoidCallback onReport;

  const ChatRoomHeader({
    super.key,
    required this.otherUserId,
    required this.isOnline,
    required this.onToggleOnline,
    required this.onBlock,
    required this.onReport,
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
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, size: 18),
          onSelected: (value) => value == 'block' ? onBlock() : onReport(),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'block', child: Text('Block user')),
            PopupMenuItem(value: 'report', child: Text('Report user')),
          ],
        ),
      ]),
    );
  }
}
