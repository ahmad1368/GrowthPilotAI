import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';

/// One candidate requirement (Issue #228's own `Requirement` schema:
/// description/type/indicator/priority_hint), plus [startIndex]/
/// [endIndex] into the source `sanitized_text` (the AC's "View in
/// Source" link) and this app's own local [status] for the triage flow.
@immutable
class ExtractedRequirement {
  final String description;
  final RequirementType type;
  final String indicator;
  final RequirementPriorityHint priorityHint;
  final int startIndex;
  final int endIndex;
  final RequirementTriageStatus status;

  const ExtractedRequirement({
    required this.description,
    required this.type,
    required this.indicator,
    required this.priorityHint,
    required this.startIndex,
    required this.endIndex,
    this.status = RequirementTriageStatus.pending,
  });

  ExtractedRequirement copyWith({String? description, RequirementTriageStatus? status}) {
    return ExtractedRequirement(
      description: description ?? this.description,
      type: type,
      indicator: indicator,
      priorityHint: priorityHint,
      startIndex: startIndex,
      endIndex: endIndex,
      status: status ?? this.status,
    );
  }
}
