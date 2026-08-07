import 'package:growth_pilot_ai/core/data/i18n_dictionary/en_fa_dictionary.dart';
import 'package:growth_pilot_ai/core/data/i18n_dictionary/fa_en_dictionary.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/core/models/translation_result.dart';

/// Rule-based on-device translation between English and Farsi (Issue
/// #430, acceptance criteria 1 and 3) — word-for-word dictionary
/// substitution, entirely offline with zero network calls.
class TranslateMessageOnDevice {
  static TranslationResult call(String text, AppLocale source, AppLocale target) {
    final dictionary = _dictionaryFor(source, target);
    final words = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    var matched = 0;

    final translatedWords = words.map((word) {
      final key = word.toLowerCase().replaceAll(RegExp(r'[^\p{L}\p{N}]', unicode: true), '');
      final translation = dictionary[key];
      if (translation != null) matched++;
      return translation ?? word;
    }).toList();

    return TranslationResult(
      translatedText: translatedWords.join(' '),
      matchedWordCount: matched,
      totalWordCount: words.length,
    );
  }

  static Map<String, String> _dictionaryFor(AppLocale source, AppLocale target) {
    if (source == AppLocale.en && target == AppLocale.fa) return enFaDictionary;
    if (source == AppLocale.fa && target == AppLocale.en) return faEnDictionary;
    return const {};
  }
}
