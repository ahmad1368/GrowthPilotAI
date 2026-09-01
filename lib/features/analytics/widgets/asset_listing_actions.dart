import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_repos.dart';

/// Listing creation and admin screening decisions (Issue #412,
/// acceptance criterion 4) — split out of [AssetBody].
class AssetListingActions {
  final AssetRepos repos;

  AssetListingActions(this.repos);

  AssetListingEntity create(AssetListingEntity listing) {
    repos.listings.save(listing);
    return listing;
  }

  AssetListingEntity decide(AssetListingEntity listing, bool approved) {
    final updated = AssetListingEntity(
      id: listing.id,
      sellerName: listing.sellerName,
      assetName: listing.assetName,
      conditionDescription: listing.conditionDescription,
      marketValue: listing.marketValue,
      askingPrice: listing.askingPrice,
      commercialZone: listing.commercialZone,
      dbStatus: (approved ? AssetListingStatus.active : AssetListingStatus.rejected).index,
      pickupDeadline: listing.pickupDeadline,
      listedAt: listing.listedAt,
    );
    repos.listings.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: approved ? 'approved asset listing' : 'rejected asset listing',
      targetMerchant: listing.sellerName,
      previousValue: 'pending review',
      newValue: updated.status.name,
    ));
    return updated;
  }
}
