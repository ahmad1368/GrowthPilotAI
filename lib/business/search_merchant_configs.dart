import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';

/// Advanced search across merchant configuration profiles by business
/// name or ID (Issue #338, acceptance criterion 1) — a blank query
/// returns every profile, most recently updated first.
class SearchMerchantConfigs {
  static List<MerchantConfigEntity> call(
      List<MerchantConfigEntity> configs, String query) {
    final results = query.trim().isEmpty
        ? List<MerchantConfigEntity>.from(configs)
        : configs.where((c) {
            final needle = query.trim().toLowerCase();
            return c.businessName.toLowerCase().contains(needle) ||
                c.businessId.toLowerCase().contains(needle);
          }).toList();

    results.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return results;
  }
}
