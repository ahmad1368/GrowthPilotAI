import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_review_burst.dart';
import 'package:growth_pilot_ai/core/data/entities/business_rating_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  BusinessRatingEntity rating(DateTime createdAt) => BusinessRatingEntity(
      businessId: 'biz-1', raterId: 'r', punctuality: 5, accuracy: 5, communication: 5, createdAt: createdAt);

  test('flags a burst of reviews within the window', () {
    final ratings = List.generate(50, (_) => rating(now));
    expect(DetectReviewBurst.call(ratings, 'biz-1', now, threshold: 50), isTrue);
  });

  test('does not flag reviews spread out over time', () {
    final ratings = List.generate(50, (i) => rating(now.subtract(Duration(days: i))));
    expect(DetectReviewBurst.call(ratings, 'biz-1', now, threshold: 50), isFalse);
  });

  test('does not count another business\'s reviews', () {
    final ratings = List.generate(50, (_) => BusinessRatingEntity(
        businessId: 'other-biz', raterId: 'r', punctuality: 5, accuracy: 5, communication: 5, createdAt: now));
    expect(DetectReviewBurst.call(ratings, 'biz-1', now, threshold: 50), isFalse);
  });
}
