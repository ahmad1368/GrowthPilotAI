import 'package:objectbox/objectbox.dart';

/// A manually-logged customer satisfaction rating (Issue #375) — this app
/// has no post-purchase survey/notification backend, so ratings are
/// recorded manually here, the same lightweight logging pattern
/// [WasteLogEntity] uses.
@Entity()
class CsatRatingEntity {
  @Id()
  int id = 0;

  /// 1-5 satisfaction score.
  int score;

  @Index()
  @Property(type: PropertyType.date)
  DateTime date;

  String? note;

  CsatRatingEntity({
    this.id = 0,
    required this.score,
    required this.date,
    this.note,
  });
}
