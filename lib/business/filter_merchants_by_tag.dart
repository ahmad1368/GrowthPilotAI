import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';

/// Filters the admin merchant list down to profiles carrying the
/// selected tag (Issue #342, acceptance criterion 2) — a blank query
/// returns every profile.
class FilterMerchantsByTag {
  static List<MerchantTagSummary> call(List<MerchantTagSummary> summaries, String tag) {
    if (tag.trim().isEmpty) return summaries;
    final needle = tag.trim().toLowerCase();
    return summaries.where((s) => s.tags.any((t) => t.toLowerCase() == needle)).toList();
  }
}
