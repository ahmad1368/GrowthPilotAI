import 'package:growth_pilot_ai/business/group_transactions_by_customer.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/ad_campaign_roi.dart';

/// ROI per logged ad campaign (Issue #366): revenue and new-buyer
/// acquisition within the campaign's date window against its cost.
/// Conversion-funnel/impression telemetry from the issue text is scoped
/// out — this app has no ad-delivery integration to source it from.
class ComputeAdCampaignRoi {
  static List<AdCampaignRoi> call(
    List<AdCampaignEntity> campaigns,
    List<TransactionEntity> transactions,
  ) {
    final buyerGroups = GroupTransactionsByCustomer.call(transactions);
    final income =
        transactions.where((t) => t.type == TransactionType.income).toList();

    return campaigns.map((campaign) {
      final attributedRevenue = income
          .where((t) =>
              !t.date.isBefore(campaign.startDate) &&
              !t.date.isAfter(campaign.endDate))
          .fold<double>(0, (sum, t) => sum + t.amount);

      final newCustomersAcquired = buyerGroups
          .where((g) =>
              !g.firstPurchaseDate.isBefore(campaign.startDate) &&
              !g.firstPurchaseDate.isAfter(campaign.endDate))
          .length;

      final roi =
          campaign.cost <= 0 ? 0.0 : (attributedRevenue - campaign.cost) / campaign.cost;

      return AdCampaignRoi(
        name: campaign.name,
        channel: campaign.channel,
        cost: campaign.cost,
        attributedRevenue: attributedRevenue,
        newCustomersAcquired: newCustomersAcquired,
        costPerAcquisition:
            newCustomersAcquired > 0 ? campaign.cost / newCustomersAcquired : null,
        roi: roi,
        isPositiveRoi: roi >= 0,
      );
    }).toList()
      ..sort((a, b) => b.roi.compareTo(a.roi));
  }
}
