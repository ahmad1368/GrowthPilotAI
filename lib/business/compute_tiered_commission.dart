import 'package:growth_pilot_ai/business/classify_commission_tier_band.dart';
import 'package:growth_pilot_ai/business/commission_rate_for_tier_band.dart';
import 'package:growth_pilot_ai/business/compute_cumulative_transaction_count.dart';
import 'package:growth_pilot_ai/business/compute_standard_commission.dart';
import 'package:growth_pilot_ai/business/round_commission_amount.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

/// Settles one order against the graduated commission schedule (Issue
/// #425, acceptance criteria 1-4) — verified merchants (#424) get the
/// tiered rate for their cumulative volume band; unverified merchants
/// stay on the platform's standard flat rate (#420) until verified.
class ComputeTieredCommission {
  static CommissionTierRecordEntity call({
    required WholesaleOrderEntity order,
    required List<WholesaleOrderEntity> merchantOrders,
    required bool dependencyVerified,
    CommissionTierBand? overrideBand,
    required DateTime now,
  }) {
    final cumulativeCount = ComputeCumulativeTransactionCount.call(order, merchantOrders);
    final band = overrideBand ?? ClassifyCommissionTierBand.call(cumulativeCount);
    final rate = dependencyVerified ? CommissionRateForTierBand.call(band) : ComputeStandardCommission.rate;
    final amount = RoundCommissionAmount.call(order.totalAmount * rate);

    final record = CommissionTierRecordEntity(
      orderId: order.id,
      merchantName: order.buyerMerchantName,
      cumulativeTransactionCount: cumulativeCount,
      commissionRate: rate,
      commissionAmount: amount,
      isOverridden: overrideBand != null,
      dependencyVerified: dependencyVerified,
      recordedAt: now,
    );
    record.tierBand = band;
    return record;
  }
}
