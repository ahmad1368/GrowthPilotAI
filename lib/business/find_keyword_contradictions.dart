import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "Semantic Conflict Detection... e.g. Requirement A says 'must be
/// offline' while linked Requirement B assumes 'Real-time cloud sync'"
/// (Issue #240) — a naive keyword-antonym-pair heuristic, explicitly
/// NOT true semantic/LLM contradiction detection (no LLM backend
/// exists in this repo; see PR notes). Only checks the requirements
/// [FindIndirectlyAffectedByRequirement] already found linked via a
/// shared goal, per the issue's own "don't invent new links" guardrail.
class FindKeywordContradictions {
  static const _antonymPairs = [
    ['offline', 'cloud sync'],
    ['offline', 'real-time'],
    ['synchronous', 'asynchronous'],
    ['manual', 'automated'],
    ['optional', 'mandatory'],
    ['public', 'private'],
    ['real-time', 'batch'],
  ];

  static List<TraceableRequirementEntity> call(
      String description, List<TraceableRequirementEntity> candidates) {
    final lower = description.toLowerCase();
    return candidates.where((candidate) {
      final candidateLower = candidate.description.toLowerCase();
      return _antonymPairs.any((pair) =>
          (lower.contains(pair[0]) && candidateLower.contains(pair[1])) ||
          (lower.contains(pair[1]) && candidateLower.contains(pair[0])));
    }).toList();
  }
}
