import 'package:growth_pilot_ai/core/enum/voice_intent.dart';

/// Keyword-based stand-in for the issue's Gemini intent parser (Issue
/// #154). [screenContext] breaks ties for an ambiguous transcript using
/// the current screen — a reviewer on this issue found that passing
/// UI-state context alongside the transcript meaningfully improves
/// real-world accuracy over the transcript alone.
class ClassifyVoiceIntent {
  static const _createAssetKeywords = ['post', 'add product', 'new listing', 'create a listing'];
  static const _sendMessageKeywords = ['send message', 'reply', 'tell them', 'message'];
  static const _marketQueryKeywords = ['market trend', 'how is the market', 'check trends'];

  static VoiceIntent call(String transcript, {String? screenContext}) {
    final lower = transcript.toLowerCase();
    if (_createAssetKeywords.any(lower.contains)) return VoiceIntent.createAsset;
    if (_sendMessageKeywords.any(lower.contains)) return VoiceIntent.sendMessage;
    if (_marketQueryKeywords.any(lower.contains)) return VoiceIntent.marketQuery;

    if (screenContext == 'product_form') return VoiceIntent.createAsset;
    if (screenContext == 'chat_room') return VoiceIntent.sendMessage;
    return VoiceIntent.unknown;
  }
}
