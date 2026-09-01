import 'package:objectbox/objectbox.dart';

/// Which aspect of the business a logged review is about (Issue #358).
enum FeedbackDomain { productQuality, pricing, staffService, other }

/// A manually-logged customer review (Issue #358) — this app has no
/// customer-facing review/NLP backend, so free-text feedback is recorded
/// here, the same lightweight logging pattern [CsatRatingEntity] uses.
@Entity()
class ReviewFeedbackEntity {
  @Id()
  int id = 0;

  String reviewText;

  int dbDomain;

  @Index()
  @Property(type: PropertyType.date)
  DateTime submittedAt;

  ReviewFeedbackEntity({
    this.id = 0,
    required this.reviewText,
    required this.submittedAt,
    this.dbDomain = 0,
  });

  FeedbackDomain get domain => FeedbackDomain.values[dbDomain];
  set domain(FeedbackDomain value) => dbDomain = value.index;
}
