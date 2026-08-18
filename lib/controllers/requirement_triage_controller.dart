import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/deduplicate_requirements.dart';
import 'package:growth_pilot_ai/business/extract_requirements_from_text.dart';
import 'package:growth_pilot_ai/controllers/requirement_batch_selection_mixin.dart';
import 'package:growth_pilot_ai/controllers/requirement_reject_undo_mixin.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// Drives the "Requirement Triage" screen (Issue #228/#229/#231) —
/// extract, dedupe, then let the user Confirm/Edit/Reject each
/// candidate, override its AI-proposed priority/stakeholder, and select
/// a card to highlight its span in the [sourceText] (Issue #231's
/// "Smart Highlighting"). Batch-selection and reject-undo are mixed in.
class RequirementTriageController extends GetxController
    with RequirementRejectUndoMixin, RequirementBatchSelectionMixin {
  @override
  final requirements = <ExtractedRequirement>[].obs;
  final sourceText = ''.obs;
  final selectedIndex = RxnInt();

  void loadFromText(String sanitizedText) {
    sourceText.value = sanitizedText;
    final extracted = ExtractRequirementsFromText.call(sanitizedText);
    requirements.assignAll(DeduplicateRequirements.call(extracted));
    selectedIndex.value = null;
    batchSelected.clear();
    resetUndo();
  }

  void selectRequirement(int? index) => selectedIndex.value = index;

  void confirm(int index) => _setStatus(index, RequirementTriageStatus.confirmed);

  void reject(int index) {
    rememberReject(index);
    _setStatus(index, RequirementTriageStatus.rejected);
  }

  void edit(int index, String newDescription) {
    requirements[index] = requirements[index]
        .copyWith(description: newDescription, status: RequirementTriageStatus.edited);
  }

  void overridePriority(int index, RequirementMoscowPriority priority) {
    requirements[index] = requirements[index].copyWith(moscowPriority: priority);
  }

  void overrideStakeholder(int index, String stakeholder) {
    requirements[index] = requirements[index].copyWith(stakeholder: stakeholder);
  }

  void _setStatus(int index, RequirementTriageStatus status) {
    requirements[index] = requirements[index].copyWith(status: status);
  }
}
