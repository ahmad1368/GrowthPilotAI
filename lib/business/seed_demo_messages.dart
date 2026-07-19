import 'package:growth_pilot_ai/business/seed_anomaly_thread_messages.dart';
import 'package:growth_pilot_ai/business/seed_home_depot_thread_messages.dart';
import 'package:growth_pilot_ai/business/seed_recommendation_thread_messages.dart';
import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';

/// Demo messages for [SeedDemoConversations]' four threads (Issue #70),
/// keyed by the seed's index (0 = Home Depot, 1 = BC Hydro, 2 = Zenith
/// anomaly, 3 = Smart Recommendation). See [SeedHomeDepotThreadMessages]
/// (Issue #73), [SeedAnomalyThreadMessages] (Issue #74) and
/// [SeedRecommendationThreadMessages] (Issue #75) for the ACTION_CARD
/// threads.
class SeedDemoMessages {
  static List<MessageEntity> forConversation(int conversationId, int index) {
    final now = DateTime.now();
    if (index == 0) {
      return SeedHomeDepotThreadMessages.call(conversationId, now);
    }
    if (index == 2) {
      return SeedAnomalyThreadMessages.call(conversationId);
    }
    if (index == 3) {
      return SeedRecommendationThreadMessages.call(conversationId);
    }
    return [
      MessageEntity(
        conversationId: conversationId,
        senderId: 'vendor-bc-hydro',
        body: 'Your account details have been updated.',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
    ];
  }
}
