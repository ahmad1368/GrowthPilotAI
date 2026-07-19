import 'package:flutter/foundation.dart';

/// Bundles the per-row ACTION_CARD callbacks (Issues #73/#74/#75) into one
/// object so [ConversationTile]/[ConversationPreview] don't grow a new
/// constructor param for every action type added to [CardFactory].
@immutable
class ActionCardActions {
  final bool isApproving;
  final VoidCallback onApprove;
  final bool isIgnoringAnomaly;
  final VoidCallback onIgnoreAnomaly;
  final bool isProcessingRecommendation;
  final VoidCallback onActRecommendation;
  final VoidCallback onDismissRecommendation;
  final VoidCallback onSnoozeRecommendation;

  const ActionCardActions({
    required this.isApproving,
    required this.onApprove,
    required this.isIgnoringAnomaly,
    required this.onIgnoreAnomaly,
    required this.isProcessingRecommendation,
    required this.onActRecommendation,
    required this.onDismissRecommendation,
    required this.onSnoozeRecommendation,
  });
}
