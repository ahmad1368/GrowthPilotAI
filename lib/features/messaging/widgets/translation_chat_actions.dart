import 'package:growth_pilot_ai/business/build_chat_message.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_repos.dart';

/// Sends one composed message through the on-device translator and
/// persists it (Issue #430, acceptance criteria 1-2) — split out of
/// [TranslationChatBody].
class TranslationChatActions {
  final TranslationChatRepos repos;

  TranslationChatActions(this.repos);

  ChatMessageEntity send(
    String senderName,
    String text,
    AppLocale sourceLocale,
    AppLocale targetLocale,
  ) {
    final message = BuildChatMessage.call(
      senderName: senderName,
      text: text,
      sourceLocale: sourceLocale,
      targetLocale: targetLocale,
      now: DateTime.now(),
    );
    repos.messages.save(message);
    return message;
  }
}
