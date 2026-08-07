import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/compute_tiered_commission.dart';
import 'package:growth_pilot_ai/business/is_merchant_dependency_verified.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_tier_override_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_repos.dart';

/// Settlement and admin-override logic for the tiered commission
/// engine (Issue #425, acceptance criteria 1-2 and 5) — split out of
/// [TieredCommissionBody].
class TieredCommissionActions {
  final TieredCommissionRepos repos;

  TieredCommissionActions(this.repos);

  CommissionTierRecordEntity settle(WholesaleOrderEntity order) {
    final merchantOrders =
        repos.orders.getAll().where((o) => o.buyerMerchantName == order.buyerMerchantName).toList();
    final verified =
        IsMerchantDependencyVerified.call(order.buyerMerchantName, repos.dependencyEvaluations.getAll());
    final overrideBand = repos.overrides.forMerchant(order.buyerMerchantName)?.tierBand;

    final record = ComputeTieredCommission.call(
      order: order,
      merchantOrders: merchantOrders,
      dependencyVerified: verified,
      overrideBand: overrideBand,
      now: DateTime.now(),
    );
    repos.records.save(record);
    return record;
  }

  void setOverride(String merchantName, CommissionTierBand band) {
    final existing = repos.overrides.forMerchant(merchantName);
    final override = MerchantTierOverrideEntity(
      id: existing?.id ?? 0,
      merchantName: merchantName,
      reason: 'Manual admin override',
      setAt: DateTime.now(),
    )..tierBand = band;
    repos.overrides.save(override);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'commission tier override set',
      targetMerchant: merchantName,
      previousValue: existing?.tierBand.name ?? 'none',
      newValue: band.name,
    ));
  }

  void clearOverride(String merchantName) {
    final existing = repos.overrides.forMerchant(merchantName);
    if (existing == null) return;
    repos.overrides.clear(merchantName);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'commission tier override cleared',
      targetMerchant: merchantName,
      previousValue: existing.tierBand.name,
      newValue: 'none',
    ));
  }
}
