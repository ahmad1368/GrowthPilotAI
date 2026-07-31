import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/discount_campaign_impact.dart';

/// Compares revenue during each logged discount campaign's window against
/// a pre-discount daily-average baseline for a window of the same length
/// (Issue #362) — the same historical-average heuristic
/// [ComputeHolidaySalesImpact] (#388) uses, since this app has no
/// discount-code/POS backend to source actual redemption cost from.
/// The discount cost is approximated as the logged percentage applied to
/// the revenue generated during the campaign window.
class ComputeDiscountCampaignImpact {
  static List<DiscountCampaignImpact> call(
    List<DiscountCampaignEntity> campaigns,
    List<TransactionEntity> transactions,
  ) {
    final income =
        transactions.where((t) => t.type == TransactionType.income).toList();
    if (income.isEmpty || campaigns.isEmpty) return [];

    final totalIncome = income.fold(0.0, (sum, t) => sum + t.amount);
    final firstDate = income.map((t) => t.date).reduce((a, b) => a.isBefore(b) ? a : b);
    final lastDate = income.map((t) => t.date).reduce((a, b) => a.isAfter(b) ? a : b);
    final totalDays = lastDate.difference(firstDate).inDays + 1;
    final dailyAvg = totalIncome / totalDays;

    final results = campaigns.map((campaign) {
      final windowDays = campaign.endDate.difference(campaign.startDate).inDays + 1;
      final baselineRevenue = dailyAvg * windowDays;

      final campaignRevenue = income
          .where((t) =>
              !t.date.isBefore(campaign.startDate) &&
              !t.date.isAfter(campaign.endDate))
          .fold<double>(0, (sum, t) => sum + t.amount);

      final discountCost = campaignRevenue * (campaign.discountPercent / 100);
      final netProfitImpact = (campaignRevenue - discountCost) - baselineRevenue;

      return DiscountCampaignImpact(
        name: campaign.name,
        discountPercent: campaign.discountPercent,
        baselineRevenue: baselineRevenue,
        campaignRevenue: campaignRevenue,
        discountCost: discountCost,
        netProfitImpact: netProfitImpact,
        isProfitable: netProfitImpact > 0,
      );
    }).toList();

    results.sort((a, b) => b.netProfitImpact.compareTo(a.netProfitImpact));
    return results;
  }
}
