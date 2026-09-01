import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_pro_card_insight.dart';
import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';

void main() {
  test('builds insight text naming the sector for vendor diversity', () {
    final insight = BuildProCardInsight.call(FinancialDnaDimension.vendorDiversity, 'Tech');

    expect(insight.insightText, contains('Tech'));
    expect(insight.insightText, contains('vendors'));
    expect(insight.actionLabel, 'Explore Vendor Options');
  });

  test('each dimension has distinct insight text and action label', () {
    for (final dimension in FinancialDnaDimension.values) {
      final insight = BuildProCardInsight.call(dimension, 'Construction');
      expect(insight.insightText, contains('Construction'));
      expect(insight.actionLabel, isNotEmpty);
    }
  });
}
