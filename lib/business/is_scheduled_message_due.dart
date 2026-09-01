import 'package:growth_pilot_ai/core/data/entities/scheduled_chat_message_entity.dart';

/// "Message Scheduling" (Issue #317 feature #20) due-check.
class IsScheduledMessageDue {
  static bool call(ScheduledChatMessageEntity message, DateTime now) =>
      !now.isBefore(message.scheduledFor);
}
