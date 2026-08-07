import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/checkout_wholesale_cart.dart';
import 'package:growth_pilot_ai/business/record_recommendation_feedback.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_feedback_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_recommendation_repos.dart';

/// One-click requisition and dismiss handling (Issue #418, acceptance
/// criteria 3-4) — requisitioning reuses [CheckoutWholesaleCart]
/// (#411) instead of a new purchase-order flow.
class InventoryRecommendationActions {
  final InventoryRecommendationRepos repos;

  InventoryRecommendationActions(this.repos);

  void requisition(WholesaleListingEntity listing, String buyerMerchantName) {
    final result = CheckoutWholesaleCart.call(
        cart: [listing], buyerMerchantName: buyerMerchantName, now: DateTime.now());
    repos.orders.save(result.order);
    for (final sold in result.soldListings) {
      repos.listings.save(sold);
    }
    repos.feedback.save(RecordRecommendationFeedback.call(
        listing.itemName, RecommendationFeedbackStatus.accepted, DateTime.now()));
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'accepted restocking recommendation',
      targetMerchant: buyerMerchantName,
      newValue: '${listing.quantityListed}x ${listing.itemName} requisitioned',
    ));
  }

  void dismiss(String itemName) {
    repos.feedback.save(RecordRecommendationFeedback.call(
        itemName, RecommendationFeedbackStatus.dismissed, DateTime.now()));
  }
}
