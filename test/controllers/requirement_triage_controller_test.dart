import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';

void main() {
  late RequirementTriageController controller;

  const sampleText = 'The system shall log events. The system should export data.';

  setUp(() {
    controller = RequirementTriageController();
    controller.loadFromText(sampleText);
  });

  group('RequirementTriageController', () {
    test('loadFromText populates requirements and sourceText', () {
      expect(controller.requirements, isNotEmpty);
      expect(controller.sourceText.value, sampleText);
    });

    test('selectRequirement updates selectedIndex', () {
      controller.selectRequirement(0);
      expect(controller.selectedIndex.value, 0);

      controller.selectRequirement(null);
      expect(controller.selectedIndex.value, isNull);
    });

    test('reject then undoReject restores the previous status', () {
      controller.confirm(0);
      controller.reject(0);
      expect(controller.requirements[0].status, RequirementTriageStatus.rejected);
      expect(controller.canUndoReject.value, isTrue);

      controller.undoReject();
      expect(controller.requirements[0].status, RequirementTriageStatus.confirmed);
      expect(controller.canUndoReject.value, isFalse);
    });

    test('selectAllPending selects only pending requirements', () {
      controller.confirm(0);
      controller.selectAllPending();

      expect(controller.batchSelected.contains(0), isFalse);
      expect(controller.batchSelected.contains(1), isTrue);
    });

    test('approveSelected confirms every selected requirement and clears selection', () {
      controller.toggleBatchSelected(0);
      controller.toggleBatchSelected(1);

      controller.approveSelected();

      expect(controller.requirements[0].status, RequirementTriageStatus.confirmed);
      expect(controller.requirements[1].status, RequirementTriageStatus.confirmed);
      expect(controller.batchSelected, isEmpty);
    });
  });
}
