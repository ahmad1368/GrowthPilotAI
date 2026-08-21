import 'package:objectbox/objectbox.dart';

/// One Founding Member's beta feedback submission (Issue #191, #169's
/// metadata-attachment AC) — a simple rating + comment mapped to the
/// app version, current route, and business that submitted it,
/// bypassing the standard support ticket flow per the issue's "goes
/// directly to the BetaFeedback collection" note.
@Entity()
class BetaFeedbackEntity {
  @Id()
  int id = 0;

  String businessId;
  int rating; // 1-5
  String comment;
  String appVersion;
  String routeName;

  @Property(type: PropertyType.date)
  @Index()
  DateTime submittedAt;

  BetaFeedbackEntity({
    this.id = 0,
    required this.businessId,
    required this.rating,
    required this.comment,
    required this.appVersion,
    this.routeName = '',
    required this.submittedAt,
  });
}
