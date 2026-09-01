import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';

/// Marks a PENDING Smart Recommendation ACTION_CARD IGNORED in place (Issue
/// #75 "Dismiss"). No-op, returning false, once the card is no longer
/// PENDING — mirrors [IgnoreAnomalyMerchant].
class DismissRecommendation {
  static bool call(MessageEntity message) {
    if (message.dbActionCardStatus != ActionCardStatus.pending.index) {
      return false;
    }
    message.dbActionCardStatus = ActionCardStatus.ignored.index;
    return true;
  }
}
