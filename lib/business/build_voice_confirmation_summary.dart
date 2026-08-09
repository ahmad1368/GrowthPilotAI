import 'package:growth_pilot_ai/core/enum/voice_intent.dart';
import 'package:growth_pilot_ai/core/models/voice_command_action.dart';

/// "Confirmation Toast that summarizes what the AI heard" (Issue #154
/// AC) — a reviewer on this issue confirmed this step is essential:
/// users were uneasy about the AI acting without seeing this first.
class BuildVoiceConfirmationSummary {
  static String call(VoiceCommandAction action) {
    switch (action.intent) {
      case VoiceIntent.createAsset:
        final title = action.title ?? 'a new listing';
        final price = action.price != null ? ' at \$${action.price}' : '';
        return 'Post "$title"$price?';
      case VoiceIntent.sendMessage:
        return 'Send message: "${action.messageBody ?? action.transcript}"?';
      case VoiceIntent.marketQuery:
        return 'Show market trends?';
      case VoiceIntent.unknown:
        return "Sorry, I didn't understand that command.";
    }
  }
}
