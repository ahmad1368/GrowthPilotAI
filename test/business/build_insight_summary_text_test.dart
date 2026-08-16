import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_insight_summary_text.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

void main() {
  group('BuildInsightSummaryText', () {
    test('mentions the category when present', () {
      const intent = QueryIntent(category: 'fuel');
      final results = [TransactionEntity(amount: 30, date: DateTime(2026, 1, 1), description: 'Fuel')];

      final text = BuildInsightSummaryText.call(intent, results, 30);

      expect(text, "You spent \$30.00 on fuel across 1 transaction.");
    });

    test('reports no matches without inventing a total', () {
      final text = BuildInsightSummaryText.call(const QueryIntent(), [], 0);

      expect(text, "You have no matching transactions.");
    });
  });
}
