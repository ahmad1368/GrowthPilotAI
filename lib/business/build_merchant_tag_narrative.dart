import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';

/// One-sentence read summarizing how many merchant profiles carry at
/// least one tag (Issue #342).
class BuildMerchantTagNarrative {
  static String call(List<MerchantTagSummary> results) {
    if (results.isEmpty) {
      return 'No merchant profiles to tag yet — add one in the Configuration Panel first.';
    }
    final tagged = results.where((r) => r.tags.isNotEmpty).length;
    return '$tagged of ${results.length} merchant profile(s) carry at least one tag.';
  }
}
