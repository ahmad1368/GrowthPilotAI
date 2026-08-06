import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/compute_group_discount_rate.dart';
import 'package:growth_pilot_ai/business/compute_group_purchase_progress.dart';
import 'package:growth_pilot_ai/business/finalize_group_purchase.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_repos.dart';

/// Campaign creation and finalization (Issue #414, acceptance
/// criteria 3 and 5) — split out of [GroupPurchaseBody].
class GroupPurchaseActions {
  final GroupPurchaseRepos repos;

  GroupPurchaseActions(this.repos);

  GroupPurchaseEntity create(GroupPurchaseEntity purchase) {
    repos.purchases.save(purchase);
    return purchase;
  }

  GroupPurchaseEntity finalizeCampaign(GroupPurchaseEntity purchase) {
    final contributions = repos.contributions.forPurchase(purchase.id);
    final progress = ComputeGroupPurchaseProgress.call(purchase, contributions);
    final rate = ComputeGroupDiscountRate.call(progress.totalQuantity, purchase.minQuantityThreshold);
    final updated = FinalizeGroupPurchase.call(purchase);
    repos.purchases.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'finalized group purchase',
      targetMerchant: purchase.organizerName,
      previousValue: '${progress.totalQuantity} units pledged',
      newValue: '${(rate * 100).toStringAsFixed(0)}% volume discount routed to supplier',
    ));
    return updated;
  }
}
