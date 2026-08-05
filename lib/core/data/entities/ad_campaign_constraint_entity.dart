import 'package:objectbox/objectbox.dart';

/// Admin-configured time/impression/click caps for one approved
/// advertising request (Issue #409) — this app has no ad-serving
/// backend, so [EnforceCampaignConstraint] checks these caps locally
/// against telemetry already logged by [PromoCardMetricsEntity] (#402)
/// instead of a real-time serving pipeline.
@Entity()
class AdCampaignConstraintEntity {
  @Id()
  int id = 0;

  @Index()
  int advertisingRequestId;

  int maxDurationDays;
  int maxImpressions;
  int maxClicks;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  AdCampaignConstraintEntity({
    this.id = 0,
    required this.advertisingRequestId,
    required this.maxDurationDays,
    required this.maxImpressions,
    required this.maxClicks,
    required this.createdAt,
  });
}
