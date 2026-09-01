import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/pulse_category.dart';

/// One crowdsourced OmniPulse report (Issue #267/#268) — a live
/// business disruption (payment-gateway outage, customs bottleneck,
/// emergency regulation, etc.) shared with the community.
@Entity()
class PulseEventEntity {
  @Id()
  int id = 0;

  String reporterId;
  int dbCategory; // PulseCategory index
  String title;
  String description;
  String region;
  double estimatedImpactCad;
  int helpfulCount;
  int growthScoreEarned;

  @Property(type: PropertyType.date)
  @Index()
  DateTime reportedAt;

  PulseEventEntity({
    this.id = 0,
    required this.reporterId,
    required this.dbCategory,
    required this.title,
    required this.description,
    required this.region,
    required this.estimatedImpactCad,
    this.helpfulCount = 0,
    this.growthScoreEarned = 0,
    required this.reportedAt,
  });

  PulseCategory get category => PulseCategory.values[dbCategory];
}
