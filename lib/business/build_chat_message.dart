import 'package:growth_pilot_ai/business/estimate_translation_confidence.dart';
import 'package:growth_pilot_ai/business/translate_message_on_device.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// Translates and packages one composed message into a storable
/// [ChatMessageEntity] (Issue #430, acceptance criteria 1-2) — the
/// translation happens synchronously here since a dictionary lookup
/// has no meaningful latency to hide.
class BuildChatMessage {
  static ChatMessageEntity call({
    required String senderName,
    required String text,
    required AppLocale sourceLocale,
    required AppLocale targetLocale,
    required DateTime now,
  }) {
    final result = TranslateMessageOnDevice.call(text, sourceLocale, targetLocale);
    return ChatMessageEntity(
      senderName: senderName,
      originalText: text,
      originalLanguageCode: sourceLocale.languageCode,
      translatedText: result.translatedText,
      translatedLanguageCode: targetLocale.languageCode,
      translationConfidence:
          EstimateTranslationConfidence.call(result.matchedWordCount, result.totalWordCount),
      sentAt: now,
    );
  }
}
