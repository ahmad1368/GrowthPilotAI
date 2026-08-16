import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Contract for turning text into a vector (Issue #198) — a real
/// implementation would run a local ONNX/MediaPipe embedding model
/// (e.g. all-MiniLM-L6-v2); see [MockEmbeddingService] for the local
/// stand-in used today.
abstract class EmbeddingService {
  OmniResult<List<double>> embed(String text);
}
