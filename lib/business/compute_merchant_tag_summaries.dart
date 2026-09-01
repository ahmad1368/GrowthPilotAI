import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tag_entity.dart';
import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';

/// Joins every merchant profile with its distinct assigned tags (Issue
/// #342) — a merchant may have the same tag logged more than once, so
/// duplicates are collapsed per merchant, sorted by business name.
class ComputeMerchantTagSummaries {
  static List<MerchantTagSummary> call(
      List<MerchantConfigEntity> configs, List<MerchantTagEntity> tags) {
    final tagsByBusinessId = <String, Set<String>>{};
    for (final t in tags) {
      (tagsByBusinessId[t.merchantBusinessId] ??= {}).add(t.tagLabel);
    }

    final results = configs
        .map((c) => MerchantTagSummary(
              businessName: c.businessName,
              businessId: c.businessId,
              tags: (tagsByBusinessId[c.businessId] ?? {}).toList()..sort(),
            ))
        .toList();

    results.sort((a, b) => a.businessName.compareTo(b.businessName));
    return results;
  }
}
