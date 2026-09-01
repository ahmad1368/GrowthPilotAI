import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Sticky "Today"/"Yesterday"/date pill between message groups
/// (Issue #123/#136 "Sticky Date Headers" AC).
class ChatDateDivider extends StatelessWidget {
  final String label;
  const ChatDateDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(20)),
        child: Text(label, style: TextStyle(fontSize: 11, color: colors.mutedForeground)),
      ),
    );
  }
}
