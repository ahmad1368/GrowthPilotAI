import 'package:growth_pilot_ai/business/compute_commission_revenue_report.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';
import 'package:growth_pilot_ai/core/models/merchant_commission_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_repos.dart';

/// Snapshot of everything [TieredCommissionView] needs to render,
/// loaded in one pass from [TieredCommissionRepos] (Issue #425).
class TieredCommissionViewState {
  final List<WholesaleOrderEntity> orders;
  final List<CommissionTierRecordEntity> records;
  final List<MerchantCommissionSummary> summaries;
  final Map<String, CommissionTierBand?> overrides;

  const TieredCommissionViewState({
    required this.orders,
    required this.records,
    required this.summaries,
    required this.overrides,
  });

  factory TieredCommissionViewState.load(TieredCommissionRepos repos) {
    final orders = repos.orders.getAll();
    final records = repos.records.getAll();
    final merchantNames = orders.map((o) => o.buyerMerchantName).toSet();
    return TieredCommissionViewState(
      orders: orders,
      records: records,
      summaries: ComputeCommissionRevenueReport.call(records),
      overrides: {for (final n in merchantNames) n: repos.overrides.forMerchant(n)?.tierBand},
    );
  }
}
