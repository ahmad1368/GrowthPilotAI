import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';

/// Selects which approved advertising request to render as a sponsored
/// feed card for the current viewing context (Issue #402, acceptance
/// criterion 2) — this app has no ad-serving backend or user-interaction
/// history, so "user context" is the sector the admin is currently
/// viewing the dashboard as. Prefers a category matching that sector,
/// falling back to the most recently approved request so the feed slot
/// isn't left empty.
class SelectPromoCardForContext {
  static AdvertisingRequestEntity? call(
      List<AdvertisingRequestEntity> requests, BusinessSector sector) {
    final approved =
        requests.where((r) => r.status == AdRequestStatus.approved).toList();
    if (approved.isEmpty) return null;

    final sectorMatches =
        approved.where((r) => r.category.toLowerCase() == sector.name.toLowerCase());
    if (sectorMatches.isNotEmpty) {
      return sectorMatches.reduce((a, b) => b.requestedAt.isAfter(a.requestedAt) ? b : a);
    }

    return approved.reduce((a, b) => b.requestedAt.isAfter(a.requestedAt) ? b : a);
  }
}
