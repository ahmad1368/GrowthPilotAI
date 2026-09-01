import 'package:growth_pilot_ai/core/data/entities/embedding_entity.dart';

/// Formats retrieved fragments as the "Context: ..." prefix the issue's
/// own worked example shows, ready to prepend to an LLM prompt (Issue
/// #198's "Prompt Injection" step).
class BuildRagPromptContext {
  static String call(List<EmbeddingEntity> fragments) {
    if (fragments.isEmpty) return '';
    final context = fragments.map((f) => f.sourceText).join('; ');
    return 'Context: $context.';
  }
}
