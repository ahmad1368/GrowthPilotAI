import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_type.dart';

/// Human-readable read of a merchant's current commission structure
/// (Issue #348) — shared by the profile row display and the audit
/// trail's before/after value strings (acceptance criterion 3).
class DescribeCommissionStructure {
  static String call(MerchantConfigEntity config) {
    return switch (config.commissionType) {
      CommissionType.percentage => '${config.commissionRatePercent}%',
      CommissionType.fixedAmount => '\$${config.commissionFixedAmount} flat',
    };
  }
}
