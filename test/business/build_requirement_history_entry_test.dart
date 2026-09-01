import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_requirement_history_entry.dart';
import 'package:growth_pilot_ai/core/enum/requirement_change_type.dart';

void main() {
  group('BuildRequirementHistoryEntry', () {
    test('stamps changedBy, the change type, and links the requirement', () {
      final entry = BuildRequirementHistoryEntry.call(
        requirementId: 42,
        type: RequirementChangeType.insert,
        newValue: 'The system shall log events.',
        reason: 'Linked to goal',
      );

      expect(entry.changedBy, 'local-user');
      expect(entry.changeType, RequirementChangeType.insert);
      expect(entry.requirement.targetId, 42);
      expect(entry.newValue, 'The system shall log events.');
      expect(entry.reasonForChange, 'Linked to goal');
    });
  });
}
