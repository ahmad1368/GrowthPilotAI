import 'package:growth_pilot_ai/core/models/consumer_behavior_insight.dart';

/// Turns a [ConsumerBehaviorInsight] into one human-readable recommendation
/// sentence (Issue #353's `CONSUMER_BEHAVIOR_SEGMENTS` widget).
class BuildConsumerBehaviorRecommendation {
  static String call(ConsumerBehaviorInsight insight) {
    switch (insight.fitTier) {
      case LowIncomeFitTier.strong:
        return 'Your basket mix is a strong fit for budget-conscious, '
            'low-income shoppers - keep essential goods well-stocked.';
      case LowIncomeFitTier.moderate:
        return 'Your basket mix has moderate appeal to low-income shoppers - '
            'consider adding smaller, lower-priced options.';
      case LowIncomeFitTier.weak:
        return 'Your basket mix skews above what budget-conscious shoppers '
            'typically spend per visit - a value tier could widen your reach.';
    }
  }
}
