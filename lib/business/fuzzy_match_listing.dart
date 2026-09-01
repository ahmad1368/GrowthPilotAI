import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/utils/string_similarity.dart';

/// Scores how well a catalog listing matches a free-text search term
/// (Issue #121, "Fuzzy Text Matching") using the existing Dice-bigram
/// [StringSimilarity] instead of an N-gram/Elasticsearch dependency.
/// Whitespace is stripped before comparing so "Nest JS" still matches
/// a "NestJS" tag, per the acceptance criterion example.
class FuzzyMatchListing {
  static double call(CatalogListingEntity listing, String term) {
    final needle = term.replaceAll(' ', '').toLowerCase();
    if (needle.isEmpty) return 1.0;
    final fields = [listing.title, listing.sector, listing.category, listing.tagsCsv];
    var best = 0.0;
    for (final field in fields) {
      final haystack = field.replaceAll(' ', '');
      if (haystack.toLowerCase().contains(needle)) return 1.0;
      final score = StringSimilarity.compare(needle, haystack);
      if (score > best) best = score;
    }
    return best;
  }
}
