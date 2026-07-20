import 'package:get/get.dart';

/// Multi-select UI state for the Inbox (Issue #76): long-press enters
/// selection mode; tapping a row toggles it in/out. Extracted from
/// [InboxController] to keep that file within the 50-line limit.
class SelectionHandler {
  final selectionMode = false.obs;
  final selectedIds = <int>{}.obs;

  bool isSelected(int conversationId) => selectedIds.contains(conversationId);

  void enter(int conversationId) {
    selectionMode.value = true;
    selectedIds.add(conversationId);
  }

  void toggle(int conversationId) {
    if (selectedIds.contains(conversationId)) {
      selectedIds.remove(conversationId);
      if (selectedIds.isEmpty) selectionMode.value = false;
    } else {
      selectedIds.add(conversationId);
    }
  }

  void selectAll(List<int> conversationIds) => selectedIds.addAll(conversationIds);

  void exit() {
    selectionMode.value = false;
    selectedIds.clear();
  }
}
