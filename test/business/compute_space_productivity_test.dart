import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_space_productivity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(double amount) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'sale', dbType: 1);

TransactionEntity _expense(double amount) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'cost', dbType: 0);

void main() {
  test('divides total income by square footage', () {
    final result =
        ComputeSpaceProductivity.call([_income(1000), _income(500)], 100);
    expect(result.totalRevenue, 1500);
    expect(result.revenuePerSquareFoot, 15.0);
  });

  test('ignores expense transactions', () {
    final result = ComputeSpaceProductivity.call([_income(1000), _expense(9999)], 100);
    expect(result.totalRevenue, 1000);
  });

  test('zero square footage yields a zero index without dividing by zero', () {
    final result = ComputeSpaceProductivity.call([_income(1000)], 0);
    expect(result.revenuePerSquareFoot, 0);
    expect(result.hasSquareFootage, isFalse);
  });

  test('positive square footage reports hasSquareFootage true', () {
    final result = ComputeSpaceProductivity.call([_income(1000)], 50);
    expect(result.hasSquareFootage, isTrue);
  });
}
