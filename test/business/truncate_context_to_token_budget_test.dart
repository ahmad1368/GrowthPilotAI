import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/truncate_context_to_token_budget.dart';
import 'package:growth_pilot_ai/core/models/context_record.dart';

ContextRecord _record(String merchant) => ContextRecord(
      date: DateTime(2026, 3, 1),
      merchant: merchant,
      amount: 100,
      category: 'fuel',
    );

void main() {
  group('TruncateContextToTokenBudget', () {
    test('keeps every record when comfortably under budget', () {
      final records = [_record('A'), _record('B')];
      expect(TruncateContextToTokenBudget.call(records, 1000).length, 2);
    });

    test('stops adding once the next record would exceed the budget', () {
      final records = [_record('A'), _record('B'), _record('C')];
      final result = TruncateContextToTokenBudget.call(records, 1);
      expect(result, isEmpty);
    });

    test('preserves the input order (most relevant first)', () {
      final records = [_record('first'), _record('second')];
      final result = TruncateContextToTokenBudget.call(records, 1000);
      expect(result.map((r) => r.merchant), ['first', 'second']);
    });
  });
}
