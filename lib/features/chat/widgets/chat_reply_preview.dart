import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The "Mini-Preview" of a reply's parent message (Issue #132) — tapping
/// it triggers the "Scroll-to-Parent" deep-link AC.
class ChatReplyPreview extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const ChatReplyPreview({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: colors.ring, width: 2)),
          color: colors.muted.withValues(alpha: 0.4),
        ),
        child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 11, color: colors.mutedForeground)),
      ),
    );
  }
}
