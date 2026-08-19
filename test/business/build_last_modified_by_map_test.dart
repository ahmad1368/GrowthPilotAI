import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_last_modified_by_map.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_history_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/enum/requirement_change_type.dart';

class _FakeRequirementHistoryRepository implements RequirementHistoryRepository {
  _FakeRequirementHistoryRepository(this._byRequirementId);

  final Map<int, List<RequirementHistoryEntity>> _byRequirementId;

  @override
  List<RequirementHistoryEntity> forRequirement(int requirementId) => _byRequirementId[requirementId] ?? [];

  @override
  void append(RequirementHistoryEntity entry) => throw UnimplementedError();
}

RequirementHistoryEntity _entry(String changedBy, DateTime changedAt) => RequirementHistoryEntity(
      dbChangeType: RequirementChangeType.insert.index,
      changedAt: changedAt,
      changedBy: changedBy,
      reasonForChange: 'test',
    );

void main() {
  group('BuildLastModifiedByMap', () {
    test('maps each requirement to its newest history entry author', () {
      final requirements = [
        TraceableRequirementEntity(id: 1, reqCode: 'BR-1', description: 'a'),
        TraceableRequirementEntity(id: 2, reqCode: 'BR-2', description: 'b'),
      ];
      final history = _FakeRequirementHistoryRepository({
        1: [_entry('newest', DateTime(2026, 3, 5)), _entry('oldest', DateTime(2026, 1, 1))],
      });

      final result = BuildLastModifiedByMap.call(requirements, history);

      expect(result[1], 'newest');
      expect(result[2], 'local-user');
    });

    test('falls back to local-user when no history exists at all', () {
      final requirements = [TraceableRequirementEntity(id: 5, reqCode: 'BR-5', description: 'c')];
      final history = _FakeRequirementHistoryRepository({});

      final result = BuildLastModifiedByMap.call(requirements, history);

      expect(result[5], 'local-user');
    });
  });
}
