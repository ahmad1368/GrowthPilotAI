import 'package:growth_pilot_ai/business/classify_voice_intent.dart';
import 'package:growth_pilot_ai/business/extract_price_term.dart';
import 'package:growth_pilot_ai/core/enum/voice_intent.dart';
import 'package:growth_pilot_ai/core/models/voice_command_action.dart';

/// "Convert this voice command into a JSON action" (Issue #154) — the
/// on-device equivalent of the issue's Gemini `VoiceIntentService`.
/// Reuses #152's [ExtractPriceTerm] rather than a second price parser.
class ExtractVoiceCommandAction {
  static const _triggerPhrases = [
    'post',
    'add product',
    'new listing',
    'create a listing',
    'send message',
    'reply',
    'tell them',
    'message',
  ];

  static VoiceCommandAction call(String transcript, {String? screenContext}) {
    final intent = ClassifyVoiceIntent.call(transcript, screenContext: screenContext);
    final remainder = _stripTriggerPhrase(transcript);

    return (
      intent: intent,
      transcript: transcript,
      title: intent == VoiceIntent.createAsset && remainder.isNotEmpty ? remainder : null,
      price: intent == VoiceIntent.createAsset ? ExtractPriceTerm.call(transcript) : null,
      messageBody: intent == VoiceIntent.sendMessage && remainder.isNotEmpty ? remainder : null,
    );
  }

  static String _stripTriggerPhrase(String transcript) {
    var remainder = transcript.trim();
    for (final phrase in _triggerPhrases) {
      final pattern = RegExp('^$phrase\\s*', caseSensitive: false);
      if (pattern.hasMatch(remainder)) {
        remainder = remainder.replaceFirst(pattern, '').trim();
        break;
      }
    }
    return remainder;
  }
}
