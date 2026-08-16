import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/determine_visual_hint.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/insight_visual_hint.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

TransactionEntity _tx() => TransactionEntity(amount: 10, date: DateTime(2026, 1, 1), description: 'x');

void main() {
  group('DetermineVisualHint', () {
    test('a multi-day range picks chart', () {
      final intent = QueryIntent(rangeStart: DateTime(2026, 1, 1), rangeEnd: DateTime(2026, 1, 31));

      expect(DetermineVisualHint.call(intent, [_tx(), _tx()]), InsightVisualHint.chart);
    });

    test('a single result with no range picks kpi', () {
      expect(DetermineVisualHint.call(const QueryIntent(), [_tx()]), InsightVisualHint.kpi);
    });

    test('an empty result with no range picks kpi', () {
      expect(DetermineVisualHint.call(const QueryIntent(), []), InsightVisualHint.kpi);
    });

    test('multiple results with no range picks list', () {
      expect(DetermineVisualHint.call(const QueryIntent(), [_tx(), _tx()]), InsightVisualHint.list);
    });
  });
}
