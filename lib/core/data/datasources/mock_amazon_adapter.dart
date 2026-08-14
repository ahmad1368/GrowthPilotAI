import 'package:growth_pilot_ai/core/interfaces/marketplace_adapter.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for the Amazon SP-API (Issue #127) — no real API key
/// or backend to call, so this emulates a successful push.
class MockAmazonAdapter implements MarketplaceAdapter {
  @override
  String get providerName => 'Amazon';

  @override
  OmniResult<String> pushListing({
    required int listingId,
    required String title,
  }) async {
    final externalId = 'amazon-$listingId';
    OmniLogger.info('Amazon: pushed listing $listingId -> $externalId');
    return OmniResponse.success(externalId);
  }

  @override
  OmniResult<void> updateAvailability({
    required String externalListingId,
    required bool isAvailable,
  }) async {
    OmniLogger.info('Amazon: $externalListingId availability -> $isAvailable');
    return OmniResponse.success(null);
  }
}
