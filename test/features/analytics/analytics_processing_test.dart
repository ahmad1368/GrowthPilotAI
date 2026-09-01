import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/domain/business/financial_analytics_processor.dart';

void main() {
  group('Financial Analytics Engine & Entity Processing Tests', () {
    final tDate = DateTime.now();

    test('Should accurately calculate 50% growth from expenses lists', () {
      final currentList = [
        TransactionEntity(
            amount: 150.0, date: tDate, description: "Test Current", dbType: 0)
      ];
      final previousList = [
        TransactionEntity(
            amount: 100.0, date: tDate, description: "Test Previous", dbType: 0)
      ];

      final comparison = FinancialAnalyticsProcessor.processComparison(
        currentRaw: currentList,
        previousRaw: previousList,
        type: TransactionType.expense,
      );

      expect(comparison.percentageChange, 50.0);
      expect(comparison.totalDifference, 50.0);
      expect(
          comparison.isNegativeTrend, true); // افزایش هزینه یعنی ترند منفی/خطر
    });

    test('Should handle zero transactions lists safely without division error',
        () {
      final comparison = FinancialAnalyticsProcessor.processComparison(
        currentRaw: [],
        previousRaw: [],
        type: TransactionType.income,
      );

      expect(comparison.percentageChange, 0.0);
      expect(comparison.totalDifference, 0.0);
      expect(comparison.isNegativeTrend, false);
    });
  });
}
