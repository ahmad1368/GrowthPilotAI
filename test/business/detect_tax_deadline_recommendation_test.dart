import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_tax_deadline_recommendation.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

void main() {
  test('flags an approaching deadline with uncategorized transactions', () {
    final rec = DetectTaxDeadlineRecommendation.call(
      daysUntilGstDeadline: 15,
      uncategorizedTransactionCount: 4,
    );

    expect(rec, isNotNull);
    expect(rec!.type, RecommendationType.taxDeadline);
    expect(rec.body, contains('15 days'));
  });

  test('does not flag when everything is already categorized', () {
    final rec = DetectTaxDeadlineRecommendation.call(
      daysUntilGstDeadline: 15,
      uncategorizedTransactionCount: 0,
    );

    expect(rec, isNull);
  });

  test('does not flag a deadline further than 30 days out', () {
    final rec = DetectTaxDeadlineRecommendation.call(
      daysUntilGstDeadline: 45,
      uncategorizedTransactionCount: 3,
    );

    expect(rec, isNull);
  });

  test('does not flag a deadline that has already passed', () {
    final rec = DetectTaxDeadlineRecommendation.call(
      daysUntilGstDeadline: -1,
      uncategorizedTransactionCount: 3,
    );

    expect(rec, isNull);
  });
}
