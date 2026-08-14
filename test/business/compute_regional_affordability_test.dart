import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_regional_affordability.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/regional_affordability_result.dart';

TransactionEntity _income(double amount) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'sale', dbType: 1);

TransactionEntity _expense(double amount) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'cost', dbType: 0);

void main() {
  test('ignores expense transactions when computing the average basket price', () {
    final result = ComputeRegionalAffordability.call([_income(50), _expense(9999)]);
    expect(result.averageBasketPrice, 50);
  });

  test('a tiny average basket relative to regional income is underpriced', () {
    final result = ComputeRegionalAffordability.call([_income(10)]);
    expect(result.tier, AffordabilityTier.underpriced);
  });

  test('a moderate average basket is well-aligned', () {
    final result = ComputeRegionalAffordability.call([_income(200)]);
    expect(result.tier, AffordabilityTier.aligned);
  });

  test('a large average basket relative to regional income is overpriced', () {
    final result = ComputeRegionalAffordability.call([_income(1000)]);
    expect(result.tier, AffordabilityTier.overpriced);
  });

  test('no transactions produces a zero index without dividing by zero', () {
    final result = ComputeRegionalAffordability.call([]);
    expect(result.averageBasketPrice, 0);
    expect(result.affordabilityIndex, 0);
  });
}
