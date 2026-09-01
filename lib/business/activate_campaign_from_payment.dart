import 'package:growth_pilot_ai/business/default_constraint_for_tier.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

/// Transitions a request straight to an active, capped campaign on
/// verified payment (Issue #410, acceptance criteria 3-4) — reuses an
/// admin-pre-configured constraint (#409) if one already exists,
/// otherwise applies the tier's default caps immediately so the
/// campaign never runs uncapped.
class ActivateCampaignFromPayment {
  static ({AdvertisingRequestEntity request, AdCampaignConstraintEntity constraint}) call({
    required AdvertisingRequestEntity request,
    AdCampaignConstraintEntity? existingConstraint,
    required DateTime now,
  }) {
    final updated = AdvertisingRequestEntity(
      id: request.id,
      merchantName: request.merchantName,
      category: request.category,
      dbPackageType: request.dbPackageType,
      dbStatus: AdRequestStatus.approved.index,
      requestedAt: request.requestedAt,
    );

    if (existingConstraint != null) {
      return (request: updated, constraint: existingConstraint);
    }

    final defaults = DefaultConstraintForTier.call(request.packageType);
    final constraint = AdCampaignConstraintEntity(
      advertisingRequestId: request.id,
      maxDurationDays: defaults.days,
      maxImpressions: defaults.impressions,
      maxClicks: defaults.clicks,
      createdAt: now,
    );
    return (request: updated, constraint: constraint);
  }
}
