import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_keyword_contradictions.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

void main() {
  group('FindKeywordContradictions', () {
    test('flags a candidate using the opposite term from a known antonym pair', () {
      final candidates = [
        TraceableRequirementEntity(
            id: 1, reqCode: 'BR-01', description: 'Assumes real-time cloud sync at all times.'),
      ];

      final result =
          FindKeywordContradictions.call('The system must be offline by default.', candidates);

      expect(result.map((r) => r.id), [1]);
    });

    test('returns nothing when no antonym pair matches', () {
      final candidates = [
        TraceableRequirementEntity(id: 1, reqCode: 'BR-01', description: 'Unrelated requirement text.'),
      ];

      final result = FindKeywordContradictions.call('Also unrelated text.', candidates);

      expect(result, isEmpty);
    });
  });
}
