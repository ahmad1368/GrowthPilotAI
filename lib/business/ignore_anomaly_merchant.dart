import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';

/// Marks a PENDING anomaly ACTION_CARD IGNORED in place (Issue #74
/// "Ignore for this Merchant"). No-op, returning false, once the card is no
/// longer PENDING. Persisting the merchant into the false-positive
/// suppression list is the caller's job ([AnomalyIgnoreHandler]) since this
/// stays a pure, repository-free check like [ApproveActionCard].
class IgnoreAnomalyMerchant {
  static bool call(MessageEntity message) {
    if (message.dbActionCardStatus != ActionCardStatus.pending.index) {
      return false;
    }
    message.dbActionCardStatus = ActionCardStatus.ignored.index;
    return true;
  }
}
