import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';

/// One fully-evaluated row for the constraint enforcement dashboard
/// (Issue #409, acceptance criteria 1-4) — bundles the request, its
/// enforcement status, and consumption percentages so the UI layer
/// only renders, it never computes.
class CampaignConstraintSnapshot {
  final AdvertisingRequestEntity request;
  final CampaignConstraintStatus status;
  final double timePercent;
  final double impressionPercent;
  final double clickPercent;
  final String? alert;

  const CampaignConstraintSnapshot({
    required this.request,
    required this.status,
    required this.timePercent,
    required this.impressionPercent,
    required this.clickPercent,
    this.alert,
  });
}
