import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/pro_card_engagement.dart';

/// One "Like the Pros" card shown to the user (Issue #85) — doubles as
/// the weekly rate-limit record ([shownAt]) and the engagement-tracking
/// record ([dbEngagement]) the "Feedback Loop" AC asks for.
@Entity()
class ProCardEventEntity {
  @Id()
  int id = 0;

  String dimension;

  @Index()
  @Property(type: PropertyType.date)
  DateTime shownAt;

  int? dbEngagement;

  ProCardEventEntity({
    this.id = 0,
    required this.dimension,
    required this.shownAt,
    this.dbEngagement,
  });

  ProCardEngagement? get engagement =>
      dbEngagement == null ? null : ProCardEngagement.values[dbEngagement!];
  set engagement(ProCardEngagement? value) => dbEngagement = value?.index;
}
