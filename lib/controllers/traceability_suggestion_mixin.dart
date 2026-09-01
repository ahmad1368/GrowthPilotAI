import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_requirement_history_entry.dart';
import 'package:growth_pilot_ai/business/generate_link_suggestions.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/suggested_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/suggested_link_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/enum/requirement_change_type.dart';
import 'package:growth_pilot_ai/core/enum/suggested_link_status.dart';

/// "AI-Powered Semantic Linker" (Issue #244), mixed into
/// `TraceabilityController`.
mixin TraceabilitySuggestionMixin on GetxController {
  SuggestedLinkRepository get suggestionRepository;
  TraceabilityLinkRepository get linkRepository;
  RequirementHistoryRepository get historyRepository;
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;
  void refreshAll();

  final suggestions = <SuggestedLinkEntity>[].obs;

  void refreshSuggestions() {
    suggestions.assignAll(
        suggestionRepository.getAll().where((s) => s.status == SuggestedLinkStatus.pending));
  }

  void generateSuggestions() {
    final generated = GenerateLinkSuggestions.call(
      goals: goalList,
      requirements: requirementList,
      existingLinks: linkRepository.goalLinksFor(),
      existingSuggestions: suggestionRepository.getAll(),
    );
    for (final suggestion in generated) {
      suggestionRepository.upsert(suggestion);
    }
    refreshSuggestions();
  }

  void approveSuggestion(SuggestedLinkEntity suggestion) {
    linkRepository.linkGoalToRequirement(suggestion.goal.targetId, suggestion.requirement.targetId);
    historyRepository.append(BuildRequirementHistoryEntry.call(
      requirementId: suggestion.requirement.targetId,
      type: RequirementChangeType.insert,
      newValue: suggestion.reasoning,
      reason: 'AI-suggested link approved',
    ));
    suggestion.status = SuggestedLinkStatus.approved;
    suggestionRepository.upsert(suggestion);
    refreshAll();
    refreshSuggestions();
  }

  void rejectSuggestion(SuggestedLinkEntity suggestion) {
    suggestion.status = SuggestedLinkStatus.rejected;
    suggestionRepository.upsert(suggestion);
    refreshSuggestions();
  }
}
