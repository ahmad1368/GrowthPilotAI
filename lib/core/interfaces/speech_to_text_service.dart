import 'dart:typed_data';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// "Whisper Transcription Engine" contract (Issue #154) — a real
/// implementation would call the OpenAI Whisper API or the on-device
/// `speech_to_text` plugin for the "Low-Bandwidth" fallback the AC
/// asks for. [languageCode] is required (not auto-detected) per this
/// issue's own review feedback, which found auto-detect adds 200-300ms
/// and misfires on mid-sentence code-switching in multilingual chat.
abstract class SpeechToTextService {
  OmniResult<String> transcribe(Uint8List audioBytes, {required String languageCode});
}
