import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';

/// One-sentence read naming how many merchant profiles are configured
/// and which was edited most recently (Issue #338).
class BuildMerchantConfigNarrative {
  static String call(List<MerchantConfigEntity> results) {
    if (results.isEmpty) {
      return 'No merchant profiles configured yet — add one to start editing parameters.';
    }
    final latest = results.first;
    return '${results.length} merchant profile(s) configured — most recently '
        '"${latest.businessName}" (${latest.businessId}) at '
        '${latest.commissionRatePercent.toStringAsFixed(1)}% commission.';
  }
}
