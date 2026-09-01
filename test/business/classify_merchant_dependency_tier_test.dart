import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_merchant_dependency_tier.dart';
import 'package:growth_pilot_ai/core/enum/merchant_dependency_tier.dart';

void main() {
  test('classifies low scores as standard', () {
    expect(ClassifyMerchantDependencyTier.call(0), MerchantDependencyTier.standard);
    expect(ClassifyMerchantDependencyTier.call(39), MerchantDependencyTier.standard);
  });

  test('classifies mid-range scores as engaged', () {
    expect(ClassifyMerchantDependencyTier.call(40), MerchantDependencyTier.engaged);
    expect(ClassifyMerchantDependencyTier.call(74), MerchantDependencyTier.engaged);
  });

  test('classifies high scores as highDependency', () {
    expect(ClassifyMerchantDependencyTier.call(75), MerchantDependencyTier.highDependency);
    expect(ClassifyMerchantDependencyTier.call(100), MerchantDependencyTier.highDependency);
  });
}
