import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Drill-down: tapping a chart segment... navigate to a filtered view
/// of the Requirements List" (Issue #234), mixed into
/// `RequirementTriageController`. Exposes original-list indices (not a
/// filtered copy) so callers can still address `requirements[i]` for
/// Confirm/Edit/Reject.
mixin RequirementTypeFilterMixin on GetxController {
  RxList<ExtractedRequirement> get requirements;

  final typeFilter = Rxn<RequirementType>();

  void setTypeFilter(RequirementType? type) => typeFilter.value = type;

  List<int> get visibleIndices {
    final filter = typeFilter.value;
    if (filter == null) return [for (var i = 0; i < requirements.length; i++) i];
    return [for (var i = 0; i < requirements.length; i++) if (requirements[i].type == filter) i];
  }
}
