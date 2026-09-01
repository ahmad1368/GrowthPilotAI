import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/action_card_actions.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/conversation_tile.dart';

/// Wraps [ConversationTile] with the Issue #76 gestures (swipe-right to
/// archive, long-press to enter multi-select, tap-to-toggle a checkbox once
/// selection mode is active) plus the Issue #78 "open marks read" tap.
class DismissibleConversationTile extends StatelessWidget {
  final ConversationSummary summary;
  final ActionCardActions actions;
  final bool selectionMode;
  final bool isSelected;
  final VoidCallback onLongPress;
  final VoidCallback onToggleSelected;
  final VoidCallback onArchive;
  final VoidCallback onOpen;

  const DismissibleConversationTile({
    super.key,
    required this.summary,
    required this.actions,
    required this.selectionMode,
    required this.isSelected,
    required this.onLongPress,
    required this.onToggleSelected,
    required this.onArchive,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final row = GestureDetector(
      onLongPress: selectionMode ? null : onLongPress,
      onTap: selectionMode ? onToggleSelected : null,
      child: Row(
        children: [
          if (selectionMode)
            Checkbox(value: isSelected, onChanged: (_) => onToggleSelected()),
          Expanded(
            child: ConversationTile(
                summary: summary, onTap: onOpen, actions: actions),
          ),
        ],
      ),
    );

    if (selectionMode) return row;

    return Dismissible(
      key: ValueKey(summary.conversationId),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red.withValues(alpha: 0.15),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.archive_outlined),
      ),
      onDismissed: (_) => onArchive(),
      child: row,
    );
  }
}
