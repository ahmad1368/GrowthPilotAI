import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/action_card_actions.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/card_factory.dart';

/// A [ConversationTile]'s subtitle (Issue #72): the plain last-message
/// text, or — when the latest message is an ACTION_CARD (Issues #73/74) —
/// the [CardFactory] widget for it.
class ConversationPreview extends StatelessWidget {
  final ConversationSummary summary;
  final ActionCardActions actions;

  const ConversationPreview({
    super.key,
    required this.summary,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final actionCard = summary.actionCard;
    if (actionCard == null) {
      return Text(
        summary.lastMessagePreview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: CardFactory.build(data: actionCard, actions: actions),
    );
  }
}
