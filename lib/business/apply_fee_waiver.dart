import 'package:growth_pilot_ai/business/compute_standard_commission.dart';
import 'package:growth_pilot_ai/business/is_first_marketplace_transaction.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

/// Decides whether one order qualifies for the zero-commission
/// incentive and records the outcome (Issue #420, acceptance
/// criteria 1-2 and 4) — a merchant who already holds a waiver record
/// can never claim a second one, even if this order is otherwise
/// eligible, closing the double-claim exploit acceptance criterion 4
/// calls out.
class ApplyFeeWaiver {
  static FeeWaiverRecordEntity call({
    required WholesaleOrderEntity order,
    required List<WholesaleOrderEntity> merchantOrders,
    required bool merchantAlreadyHasWaiver,
    required DateTime now,
  }) {
    final isFirst = IsFirstMarketplaceTransaction.call(order, merchantOrders);
    final isWaived = isFirst && !merchantAlreadyHasWaiver;
    final commission = ComputeStandardCommission.call(order.totalAmount);
    return FeeWaiverRecordEntity(
      orderId: order.id,
      merchantName: order.buyerMerchantName,
      grossAmount: order.totalAmount,
      commissionRate: ComputeStandardCommission.rate,
      commissionAmount: commission,
      waivedAmount: isWaived ? commission : 0,
      isWaived: isWaived,
      recordedAt: now,
    );
  }
}
