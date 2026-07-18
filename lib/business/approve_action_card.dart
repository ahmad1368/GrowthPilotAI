import 'package:growth_pilot_ai/core/data/entities/message_entity.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';

/// Marks a PENDING action card COMPLETED in place (Issue #73) — the
/// client-side stand-in for the NestJS "Approve & Sync" action handler
/// this repo has no backend for. No-op, returning false, once already
/// COMPLETED/EXPIRED, so a message approved twice (e.g. a double-tap that
/// slips past the UI guard) can't be re-processed.
class ApproveActionCard {
  static bool call(MessageEntity message) {
    if (message.dbActionCardStatus != ActionCardStatus.pending.index) {
      return false;
    }
    message.dbActionCardStatus = ActionCardStatus.completed.index;
    return true;
  }
}
