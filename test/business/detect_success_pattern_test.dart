import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_success_pattern.dart';
import 'package:growth_pilot_ai/core/models/financial_dna_vector.dart';

void main() {
  const successVector = FinancialDnaVector(
    liquidityRatio: 2.0,
    burnVelocity: 1.2,
    vendorDiversity: 5.0,
    paymentPunctuality: 10.0,
  );

  test('an identical (scaled) vector is a High-Growth match', () {
    const userVector = FinancialDnaVector(
      liquidityRatio: 4.0,
      burnVelocity: 2.4,
      vendorDiversity: 10.0,
      paymentPunctuality: 20.0,
    );

    final result = DetectSuccessPattern.call(userVector, successVector);

    expect(result.isHighGrowthMatch, isTrue);
    expect(result.similarityScore, closeTo(1.0, 1e-9));
    expect(result.divergentDimension, isNull);
  });

  test('a clearly different vector is not a match and names a divergent dimension', () {
    const userVector = FinancialDnaVector(
      liquidityRatio: 0.1,
      burnVelocity: 9.0,
      vendorDiversity: 0.2,
      paymentPunctuality: 1.0,
    );

    final result = DetectSuccessPattern.call(userVector, successVector);

    expect(result.isHighGrowthMatch, isFalse);
    expect(result.divergentDimension, isNotNull);
  });
}
