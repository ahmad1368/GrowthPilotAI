import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_compass_insight_narrative.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';

void main() {
  test('names the axis with the largest user-behind-sector gap', () {
    const user = BusinessCompassMetrics(
      liquidityRatio: 0.7,
      burnVelocity: 0.5,
      vendorDiversity: 0.2, // biggest gap: 0.9 - 0.2 = 0.7
      paymentPunctuality: 0.8,
      profitMargin: 0.5,
    );
    const sector = BusinessCompassMetrics(
      liquidityRatio: 0.75,
      burnVelocity: 0.5,
      vendorDiversity: 0.9,
      paymentPunctuality: 0.85,
      profitMargin: 0.55,
    );

    final narrative = BuildCompassInsightNarrative.call(user, sector);

    expect(narrative, contains('Vendor Diversity'));
    expect(narrative, contains('20%'));
    expect(narrative, contains('90%'));
  });

  test('returns a positive message when user meets or beats every axis', () {
    const user = BusinessCompassMetrics(
      liquidityRatio: 0.9,
      burnVelocity: 0.9,
      vendorDiversity: 0.9,
      paymentPunctuality: 0.9,
      profitMargin: 0.9,
    );
    const sector = BusinessCompassMetrics(
      liquidityRatio: 0.5,
      burnVelocity: 0.5,
      vendorDiversity: 0.5,
      paymentPunctuality: 0.5,
      profitMargin: 0.5,
    );

    final narrative = BuildCompassInsightNarrative.call(user, sector);

    expect(narrative, 'You\'re at or above the sector benchmark on every axis.');
  });
}
