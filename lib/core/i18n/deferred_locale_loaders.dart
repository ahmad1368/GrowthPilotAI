import 'package:growth_pilot_ai/core/i18n/translations/fr_translations.dart' deferred as fr;
import 'package:growth_pilot_ai/core/i18n/translations/zh_translations.dart' deferred as zh;
import 'package:growth_pilot_ai/core/i18n/translations/pa_translations.dart' deferred as pa;
import 'package:growth_pilot_ai/core/i18n/translations/es_translations.dart' deferred as es;
import 'package:growth_pilot_ai/core/i18n/translations/fa_translations.dart' deferred as fa;
import 'package:growth_pilot_ai/core/i18n/translations/ar_translations.dart' deferred as ar;

/// Per-locale deferred-library loaders (Issue #429, acceptance
/// criterion 5) — split out of [LocaleBundleLoader] to keep both
/// files under the line cap; each function awaits its own lazily
/// compiled library chunk and returns its exported translation map.
Future<Map<String, String>> loadFrBundle() async {
  await fr.loadLibrary();
  return fr.frTranslations;
}

Future<Map<String, String>> loadZhBundle() async {
  await zh.loadLibrary();
  return zh.zhTranslations;
}

Future<Map<String, String>> loadPaBundle() async {
  await pa.loadLibrary();
  return pa.paTranslations;
}

Future<Map<String, String>> loadEsBundle() async {
  await es.loadLibrary();
  return es.esTranslations;
}

Future<Map<String, String>> loadFaBundle() async {
  await fa.loadLibrary();
  return fa.faTranslations;
}

Future<Map<String, String>> loadArBundle() async {
  await ar.loadLibrary();
  return ar.arTranslations;
}
