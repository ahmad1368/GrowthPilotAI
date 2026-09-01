import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// Shared `ExtractedRequirement` builder for KPI-engine tests (Issue
/// #233/#236) — only the fields a given test cares about need
/// overriding.
ExtractedRequirement buildTestRequirement({
  RequirementType type = RequirementType.functional,
  RequirementMoscowPriority moscowPriority = RequirementMoscowPriority.shouldHave,
  RequirementTriageStatus status = RequirementTriageStatus.pending,
  String stakeholder = 'Unassigned',
}) {
  return ExtractedRequirement(
    description: 'The system shall do something.',
    type: type,
    indicator: 'shall',
    priorityHint: RequirementPriorityHint.medium,
    moscowPriority: moscowPriority,
    stakeholder: stakeholder,
    startIndex: 0,
    endIndex: 10,
    confidence: 0.9,
    status: status,
  );
}
