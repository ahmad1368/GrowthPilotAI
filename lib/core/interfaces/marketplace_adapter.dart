import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// "Marketplace Adapter Interface" (Issue #127) — one implementation per
/// external provider (eBay, Amazon SP-API, ...); the sync usecase stays
/// decoupled from which ones are active.
abstract class MarketplaceAdapter {
  String get providerName;

  /// Pushes the listing and resolves to the provider's external id.
  OmniResult<String> pushListing({
    required int listingId,
    required String title,
  });

  OmniResult<void> updateAvailability({
    required String externalListingId,
    required bool isAvailable,
  });
}
