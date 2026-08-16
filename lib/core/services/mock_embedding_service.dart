import 'dart:math';
import 'package:growth_pilot_ai/core/interfaces/embedding_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Local stand-in for a real on-device embedding model (Issue #198) —
/// no ONNX/MediaPipe model is integrated, matching #71's
/// [MockNotificationChannel] precedent of "no native SDK call".
/// Produces a deterministic 384-dimension vector seeded from the
/// text's hash so the pipeline is exercisable end-to-end; it is NOT
/// semantically meaningful and must not be used to judge real search
/// relevance.
class MockEmbeddingService implements EmbeddingService {
  static const dimensions = 384;

  @override
  OmniResult<List<double>> embed(String text) async {
    final random = Random(text.hashCode);
    final vector = List.generate(dimensions, (_) => random.nextDouble() * 2 - 1);
    return OmniResponse.success(vector);
  }
}
