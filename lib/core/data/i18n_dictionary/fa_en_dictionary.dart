import 'package:growth_pilot_ai/core/data/i18n_dictionary/en_fa_dictionary.dart';

/// Farsi→English lookup (Issue #430) — derived from [enFaDictionary]
/// so the two translation directions can never drift out of sync.
final Map<String, String> faEnDictionary = {
  for (final entry in enFaDictionary.entries) entry.value: entry.key,
};
