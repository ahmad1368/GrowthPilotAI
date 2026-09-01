import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_review_sentiment_narrative.dart';
import 'package:growth_pilot_ai/business/compute_review_sentiment.dart';
import 'package:growth_pilot_ai/business/score_review_text.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';

ReviewFeedbackEntity _review(
  String text, {
  FeedbackDomain domain = FeedbackDomain.productQuality,
  DateTime? submittedAt,
}) =>
    ReviewFeedbackEntity(
      reviewText: text,
      submittedAt: submittedAt ?? DateTime(2024, 3, 1),
    )..domain = domain;

void main() {
  group('ScoreReviewText', () {
    test('scores positive words above zero', () {
      expect(ScoreReviewText.call('Great and friendly service'), 2);
    });

    test('scores negative words below zero', () {
      expect(ScoreReviewText.call('Rude staff and dirty tables'), -2);
    });

    test('is case-insensitive and ignores punctuation', () {
      expect(ScoreReviewText.call('GREAT! Really GREAT.'), 2);
    });

    test('returns 0 for neutral text', () {
      expect(ScoreReviewText.call('The store is downtown'), 0);
    });
  });

  group('ComputeReviewSentiment', () {
    test('returns empty list when no reviews are logged', () {
      expect(ComputeReviewSentiment.call(const []), isEmpty);
    });

    test('computes sentiment score per review', () {
      final result =
          ComputeReviewSentiment.call([_review('Terrible and slow')]).single;

      expect(result.sentimentScore, -2);
      expect(result.isNegative, isTrue);
      expect(result.isPositive, isFalse);
    });

    test('sorts reviews by sentiment score ascending (worst first)', () {
      final results = ComputeReviewSentiment.call([
        _review('Great friendly amazing'),
        _review('Terrible rude awful'),
      ]);

      expect(results.first.reviewText, 'Terrible rude awful');
      expect(results.last.reviewText, 'Great friendly amazing');
    });
  });

  group('BuildReviewSentimentNarrative', () {
    test('falls back when no reviews are logged', () {
      expect(BuildReviewSentimentNarrative.call(const []),
          contains('No reviews logged'));
    });

    test('names the biggest concern and strongest praise when multiple exist', () {
      final results = ComputeReviewSentiment.call([
        _review('Great friendly amazing', domain: FeedbackDomain.staffService),
        _review('Terrible rude awful', domain: FeedbackDomain.pricing),
      ]);
      final narrative = BuildReviewSentimentNarrative.call(results);

      expect(narrative, contains('pricing'));
      expect(narrative, contains('staffService'));
    });
  });
}
