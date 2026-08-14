import 'package:growth_pilot_ai/business/apply_fee_waiver.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/fee_waiver_repos.dart';

/// Fee-waiver evaluation and audit logging (Issue #420, acceptance
/// criteria 2 and 4) — split out of [FeeWaiverBody].
class FeeWaiverActions {
  final FeeWaiverRepos repos;

  FeeWaiverActions(this.repos);

  FeeWaiverRecordEntity evaluate(WholesaleOrderEntity order) {
    final merchantOrders =
        repos.orders.getAll().where((o) => o.buyerMerchantName == order.buyerMerchantName).toList();
    final record = ApplyFeeWaiver.call(
      order: order,
      merchantOrders: merchantOrders,
      merchantAlreadyHasWaiver: repos.records.hasWaiverFor(order.buyerMerchantName),
      now: DateTime.now(),
    );
    repos.records.save(record);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: record.isWaived ? 'waived marketplace commission' : 'charged marketplace commission',
      targetMerchant: order.buyerMerchantName,
      newValue: record.isWaived
          ? '\$${record.waivedAmount.toStringAsFixed(2)} waived on order #${order.id}'
          : '\$${record.commissionAmount.toStringAsFixed(2)} charged on order #${order.id}',
    ));
    return record;
  }
}
