import '../../../../objectbox.g.dart';
import '../entities/ai_response_feedback_entity.dart';

/// Thin ObjectBox wrapper for [AiResponseFeedbackEntity] rows (Issue #209).
class AiResponseFeedbackRepository {
  final Box<AiResponseFeedbackEntity> _box;

  AiResponseFeedbackRepository(this._box);

  List<AiResponseFeedbackEntity> getAll() => _box.getAll();

  void add(AiResponseFeedbackEntity feedback) => _box.put(feedback);
}
