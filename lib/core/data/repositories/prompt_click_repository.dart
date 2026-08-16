import '../../../../objectbox.g.dart';
import '../entities/prompt_click_entity.dart';

/// Thin ObjectBox wrapper for [PromptClickEntity] rows (Issue #201).
class PromptClickRepository {
  final Box<PromptClickEntity> _box;

  PromptClickRepository(this._box);

  List<PromptClickEntity> getAll() => _box.getAll();

  void recordClick(String promptText) {
    final existing = _box
        .query(PromptClickEntity_.promptText.equals(promptText))
        .build()
        .findFirst();
    if (existing != null) {
      existing.clickCount += 1;
      existing.lastClickedAt = DateTime.now();
      _box.put(existing);
    } else {
      _box.put(PromptClickEntity(promptText: promptText, clickCount: 1, lastClickedAt: DateTime.now()));
    }
  }
}
