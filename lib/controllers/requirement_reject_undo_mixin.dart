import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Add an 'Undo' feature for accidental rejections" (Issue #231) —
/// single-level undo, mixed into `RequirementTriageController`.
mixin RequirementRejectUndoMixin on GetxController {
  RxList<ExtractedRequirement> get requirements;

  int? _lastRejectedIndex;
  RequirementTriageStatus? _lastRejectedPreviousStatus;
  final canUndoReject = false.obs;

  void rememberReject(int index) {
    _lastRejectedIndex = index;
    _lastRejectedPreviousStatus = requirements[index].status;
    canUndoReject.value = true;
  }

  void undoReject() {
    final index = _lastRejectedIndex;
    final previous = _lastRejectedPreviousStatus;
    if (index == null || previous == null) return;
    requirements[index] = requirements[index].copyWith(status: previous);
    canUndoReject.value = false;
    _lastRejectedIndex = null;
    _lastRejectedPreviousStatus = null;
  }

  void resetUndo() => canUndoReject.value = false;
}
