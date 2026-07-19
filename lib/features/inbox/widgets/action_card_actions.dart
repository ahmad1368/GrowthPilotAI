import 'package:flutter/foundation.dart';

/// Bundles the per-row ACTION_CARD callbacks (Issues #73/#74) into one
/// object so [ConversationTile]/[ConversationPreview] don't grow a new
/// constructor param for every action type added to [CardFactory].
@immutable
class ActionCardActions {
  final bool isApproving;
  final VoidCallback onApprove;
  final bool isIgnoringAnomaly;
  final VoidCallback onIgnoreAnomaly;

  const ActionCardActions({
    required this.isApproving,
    required this.onApprove,
    required this.isIgnoringAnomaly,
    required this.onIgnoreAnomaly,
  });
}
