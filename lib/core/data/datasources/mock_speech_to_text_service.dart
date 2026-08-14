import 'dart:convert';
import 'dart:typed_data';
import 'package:growth_pilot_ai/core/interfaces/speech_to_text_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Local stand-in for Whisper/on-device STT (Issue #154) — no audio
/// engine exists locally to genuinely transcribe PCM bytes, so this
/// decodes [audioBytes] as UTF-8 text instead of fabricating a
/// transcript. In practice this is fed by a "type your command"
/// text-input fallback until a real STT engine is wired up.
class MockSpeechToTextService implements SpeechToTextService {
  @override
  OmniResult<String> transcribe(Uint8List audioBytes, {required String languageCode}) async {
    try {
      return OmniResponse.success(utf8.decode(audioBytes));
    } catch (_) {
      return OmniResponse.error('Unable to transcribe audio');
    }
  }
}
