import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/deduplicate_requirements.dart';
import 'package:growth_pilot_ai/business/extract_requirements_from_text.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// Drives the "Requirement Triage" screen (Issue #228/#229) — extract,
/// dedupe, then let the user Confirm/Edit/Reject each candidate, or
/// manually override its AI-proposed priority/stakeholder (Issue #229's
/// AC: "Since AI isn't perfect... every field must be a dropdown").
class RequirementTriageController extends GetxController {
  final requirements = <ExtractedRequirement>[].obs;

  void loadFromText(String sanitizedText) {
    final extracted = ExtractRequirementsFromText.call(sanitizedText);
    requirements.assignAll(DeduplicateRequirements.call(extracted));
  }

  void confirm(int index) => _setStatus(index, RequirementTriageStatus.confirmed);
  void reject(int index) => _setStatus(index, RequirementTriageStatus.rejected);

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
