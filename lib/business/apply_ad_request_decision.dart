import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

/// Applies an admin's approve/deny decision to a pending advertising
/// request (Issue #401) — pure construction, mirroring
/// [ApplyCapExpansionDecision] (#344).
class ApplyAdRequestDecision {
  static AdvertisingRequestEntity call(AdvertisingRequestEntity request, bool approved) {
    return AdvertisingRequestEntity(
      id: request.id,
      merchantName: request.merchantName,
      category: request.category,
      dbPackageType: request.dbPackageType,
      dbStatus: (approved ? AdRequestStatus.approved : AdRequestStatus.denied).index,
      requestedAt: request.requestedAt,
    );
  }
}
