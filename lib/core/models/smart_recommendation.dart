import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

/// One proactive tip (Issue #75): output of a `Detect*Recommendation` rule,
/// consumed by [BuildRecommendationActionCardMessage]/
/// [BuildRecommendationNotification]. [actionLabel] is the CTA button text
/// (e.g. "View Fuel Report"); [metadataRefId] links back to the
/// subscription/transaction the tip is about, when applicable.
@immutable
class SmartRecommendation {
  final RecommendationType type;
  final String title;
  final String body;
  final String actionLabel;
  final String? metadataRefId;

  const SmartRecommendation({
    required this.type,
    required this.title,
    required this.body,
    required this.actionLabel,
    this.metadataRefId,
  });
}
