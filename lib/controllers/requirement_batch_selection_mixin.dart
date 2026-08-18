import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Batch Actions: Select All and Approve" (Issue #231), mixed into
/// `RequirementTriageController`.
mixin RequirementBatchSelectionMixin on GetxController {
  RxList<ExtractedRequirement> get requirements;

  final batchSelected = <int>{}.obs;

  void toggleBatchSelected(int index) {
    if (!batchSelected.remove(index)) batchSelected.add(index);
  }

  void selectAllPending() {
    batchSelected.assignAll([
      for (var i = 0; i < requirements.length; i++)
        if (requirements[i].status == RequirementTriageStatus.pending) i,
    ]);
  }

  void approveSelected() {
    for (final index in batchSelected) {
      requirements[index] = requirements[index].copyWith(status: RequirementTriageStatus.confirmed);
    }
    batchSelected.clear();
  }
}
