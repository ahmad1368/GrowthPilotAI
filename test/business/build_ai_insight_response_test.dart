import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_ai_insight_response.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/insight_visual_hint.dart';

void main() {
  group('BuildAiInsightResponse', () {
    final transactions = [
      TransactionEntity(amount: 40, date: DateTime(2026, 1, 5), description: 'Fido utilities'),
      TransactionEntity(amount: 60, date: DateTime(2026, 1, 20), description: 'Rogers utilities'),
      TransactionEntity(amount: 500, date: DateTime(2026, 1, 12), description: 'Office rent'),
    ];

    test('parses a category query and summarizes only the matching total', () {
      final response = BuildAiInsightResponse.call(
          'How much did I spend on utilities?', transactions, DateTime(2026, 2, 1));

      expect(response.queryParameters.category, 'utilities');
      expect(response.aiSummary, contains('100.00'));
      expect(response.aiSummary, contains('2 transactions'));
    });

    test('a query with no matches reports zero results honestly', () {
      final response = BuildAiInsightResponse.call(
          'How much did I spend on payroll?', transactions, DateTime(2026, 2, 1));

      expect(response.visualHint, InsightVisualHint.kpi);
      expect(response.aiSummary, 'You have no matching transactions.');
    });
  });
}
