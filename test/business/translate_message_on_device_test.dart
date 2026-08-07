import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/translate_message_on_device.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

void main() {
  test('translates known English words to Farsi', () {
    final result = TranslateMessageOnDevice.call('hello price', AppLocale.en, AppLocale.fa);
    expect(result.translatedText, 'سلام قیمت');
    expect(result.matchedWordCount, 2);
    expect(result.totalWordCount, 2);
  });

  test('leaves unknown words untranslated', () {
    final result = TranslateMessageOnDevice.call('hello xyzabc', AppLocale.en, AppLocale.fa);
    expect(result.translatedText, 'سلام xyzabc');
    expect(result.matchedWordCount, 1);
    expect(result.totalWordCount, 2);
  });

  test('translates Farsi back to English via the derived reverse dictionary', () {
    final result = TranslateMessageOnDevice.call('سلام قیمت', AppLocale.fa, AppLocale.en);
    expect(result.translatedText, 'hello price');
    expect(result.matchedWordCount, 2);
  });

  test('returns the original text unmatched for an unsupported language pair', () {
    final result = TranslateMessageOnDevice.call('hello', AppLocale.en, AppLocale.fr);
    expect(result.translatedText, 'hello');
    expect(result.matchedWordCount, 0);
  });
}
