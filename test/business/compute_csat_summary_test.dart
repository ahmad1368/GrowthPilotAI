import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_csat_narrative.dart';
import 'package:growth_pilot_ai/business/compute_csat_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';

CsatRatingEntity _rating(int score, DateTime date) =>
    CsatRatingEntity(score: score, date: date);

void main() {
  group('ComputeCsatSummary', () {
    test('returns zeroed summary when no ratings are logged', () {
      final summary = ComputeCsatSummary.call(const []);
      expect(summary.totalRatings, 0);
      expect(summary.averageScore, 0);
      expect(summary.trendDelta, 0);
    });

    test('computes the average score across all ratings', () {
      final ratings = [
        _rating(4, DateTime(2024, 1, 1)),
        _rating(2, DateTime(2024, 1, 2)),
      ];
      final summary = ComputeCsatSummary.call(ratings);
      expect(summary.totalRatings, 2);
      expect(summary.averageScore, 3);
    });

    test('reports a zero trend for a single rating', () {
      final summary =
          ComputeCsatSummary.call([_rating(5, DateTime(2024, 1, 1))]);
      expect(summary.trendDelta, 0);
    });

    test('flags an improving trend when recent ratings score higher', () {
      final ratings = [
        _rating(2, DateTime(2024, 1, 1)),
        _rating(2, DateTime(2024, 1, 2)),
        _rating(5, DateTime(2024, 1, 3)),
        _rating(5, DateTime(2024, 1, 4)),
      ];
      final summary = ComputeCsatSummary.call(ratings);
      expect(summary.trendDelta, closeTo(3, 1e-9));
      expect(summary.isImproving, isTrue);
    });

    test('flags a declining trend when recent ratings score lower', () {
      final ratings = [
        _rating(5, DateTime(2024, 1, 1)),
        _rating(5, DateTime(2024, 1, 2)),
        _rating(1, DateTime(2024, 1, 3)),
        _rating(1, DateTime(2024, 1, 4)),
      ];
      final summary = ComputeCsatSummary.call(ratings);
      expect(summary.trendDelta, lessThan(0));
      expect(summary.isImproving, isFalse);
    });
  });

  group('BuildCsatNarrative', () {
    test('falls back when no ratings are logged', () {
      final summary = ComputeCsatSummary.call(const []);
      expect(
          BuildCsatNarrative.call(summary), contains('No CSAT ratings logged'));
    });

    test('reports the average score and rating count', () {
      final ratings = [
        _rating(4, DateTime(2024, 1, 1)),
        _rating(4, DateTime(2024, 1, 2)),
      ];
      final summary = ComputeCsatSummary.call(ratings);
      final narrative = BuildCsatNarrative.call(summary);
      expect(narrative, contains('4.0/5'));
      expect(narrative, contains('2 ratings'));
    });
  });
}
