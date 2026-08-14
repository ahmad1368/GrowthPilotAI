import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_chat_message.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

void main() {
  test('translates and packages a composed message', () {
    final now = DateTime(2026, 1, 1);
    final message = BuildChatMessage.call(
      senderName: 'Alpha',
      text: 'hello price',
      sourceLocale: AppLocale.en,
      targetLocale: AppLocale.fa,
      now: now,
    );
    expect(message.senderName, 'Alpha');
    expect(message.originalText, 'hello price');
    expect(message.translatedText, 'سلام قیمت');
    expect(message.translationConfidence, 1.0);
    expect(message.sentAt, now);
  });

  test('confidence reflects untranslated words', () {
    final message = BuildChatMessage.call(
      senderName: 'Alpha',
      text: 'hello xyzabc',
      sourceLocale: AppLocale.en,
      targetLocale: AppLocale.fa,
      now: DateTime(2026, 1, 1),
    );
    expect(message.translationConfidence, 0.5);
  });
}
