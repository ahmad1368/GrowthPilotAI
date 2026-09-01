import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';

/// Broadcast alert for a newly-listed clearance item (Issue #411,
/// acceptance criterion 4) — this app has no push/email backend, so
/// the broadcast surfaces directly in the dashboard instead of a
/// dispatched notification, the same simplification
/// [BuildPaymentConfirmationNarrative] (#410) takes.
class BuildWholesaleNotification {
  static String call(WholesaleListingEntity listing) {
    return 'New wholesale listing: ${listing.quantityListed}x ${listing.itemName} at '
        '\$${listing.wholesalePrice.toStringAsFixed(2)}/unit — broadcast to Vancouver trade network.';
  }
}
