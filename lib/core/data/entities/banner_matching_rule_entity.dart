import 'package:objectbox/objectbox.dart';

/// An admin-defined rule correlating an analytical report topic with a
/// promotion category (Issue #403, acceptance criterion 4) — this app
/// has no ad-serving backend, so matching rules and their priority
/// weights are configured locally, persisting via ObjectBox `put`
/// (insert when `id == 0`, update in place otherwise).
@Entity()
class BannerMatchingRuleEntity {
  @Id()
  int id = 0;

  String reportTopic;

  String category;

  int priorityWeight;

  @Index()
  @Property(type: PropertyType.date)
  DateTime updatedAt;

  BannerMatchingRuleEntity({
    this.id = 0,
    required this.reportTopic,
    required this.category,
    this.priorityWeight = 1,
    required this.updatedAt,
  });
}
