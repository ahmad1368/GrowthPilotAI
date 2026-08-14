import 'package:growth_pilot_ai/business/evaluate_campaign_snapshot.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';
import 'package:growth_pilot_ai/core/models/campaign_constraint_snapshot.dart';

/// Evaluates every constrained request into a ready-to-render snapshot
/// (Issue #409) — only requests with a configured constraint appear;
/// unconstrained [requests] are simply absent from the result.
class BuildCampaignConstraintSnapshots {
  static List<CampaignConstraintSnapshot> call({
    required List<AdvertisingRequestEntity> requests,
    required List<AdCampaignConstraintEntity> constraints,
    required List<PromoCardMetricsEntity> metrics,
    required DateTime now,
  }) {
    final snapshots = <CampaignConstraintSnapshot>[];
    for (final constraint in constraints) {
      final request = _find(requests, (r) => r.id == constraint.advertisingRequestId);
      if (request == null) continue;
      final campaignMetrics =
          _find(metrics, (m) => m.advertisingRequestId == constraint.advertisingRequestId);
      snapshots.add(EvaluateCampaignSnapshot.call(request, constraint, campaignMetrics, now));
    }
    return snapshots;
  }

  static T? _find<T>(List<T> items, bool Function(T) test) {
    final matches = items.where(test);
    return matches.isEmpty ? null : matches.first;
  }
}
