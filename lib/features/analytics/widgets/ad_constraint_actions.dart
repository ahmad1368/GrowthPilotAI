import 'package:growth_pilot_ai/business/build_campaign_constraint_snapshots.dart';
import 'package:growth_pilot_ai/business/enforce_campaign_constraint.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/models/campaign_constraint_snapshot.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_repos.dart';

/// Configuration and auto-enforcement actions for the constraint
/// dashboard (Issue #409) — split out of [AdConstraintBody].
class AdConstraintActions {
  final AdConstraintRepos repos;

  AdConstraintActions(this.repos);

  void configure(int requestId, int days, int impressions, int clicks) {
    repos.constraints.save(AdCampaignConstraintEntity(
      advertisingRequestId: requestId,
      maxDurationDays: days,
      maxImpressions: impressions,
      maxClicks: clicks,
      createdAt: DateTime.now(),
    ));
  }

  List<CampaignConstraintSnapshot> buildAndEnforceSnapshots(
      List<AdvertisingRequestEntity> allRequests) {
    final snapshots = BuildCampaignConstraintSnapshots.call(
      requests: allRequests,
      constraints: repos.constraints.getAll(),
      metrics: repos.metrics.getAll(),
      now: DateTime.now(),
    );
    for (final snap in snapshots) {
      final result = EnforceCampaignConstraint.call(snap.request, snap.status);
      if (result == null) continue;
      repos.requests.save(result.request);
      repos.auditLogs.record(result.log);
    }
    return snapshots;
  }

  List<AdvertisingRequestEntity> unconstrainedRequests(
      List<AdvertisingRequestEntity> allRequests, List<CampaignConstraintSnapshot> snapshots) {
    return allRequests
        .where((r) => r.status == AdRequestStatus.approved)
        .where((r) => !snapshots.any((s) => s.request.id == r.id))
        .toList();
  }
}
