import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_most_divergent_dimension.dart';
import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';
import 'package:growth_pilot_ai/core/models/financial_dna_vector.dart';

void main() {
  test('picks the dimension with the largest gap from the success vector', () {
    const user = FinancialDnaVector(
      liquidityRatio: 1.0,
      burnVelocity: 1.0,
      vendorDiversity: 1.0,
      paymentPunctuality: 1.0,
    );
    const success = FinancialDnaVector(
      liquidityRatio: 1.1,
      burnVelocity: 3.5, // largest gap
      vendorDiversity: 1.2,
      paymentPunctuality: 0.9,
    );

    expect(FindMostDivergentDimension.call(user, success), FinancialDnaDimension.burnVelocity);
  });
}
