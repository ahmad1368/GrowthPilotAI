import 'package:growth_pilot_ai/core/enum/voice_intent.dart';
import 'package:growth_pilot_ai/core/models/voice_command_action.dart';

/// An unrecognized command has nothing to confirm/execute (Issue #154).
class IsVoiceCommandExecutable {
  static bool call(VoiceCommandAction action) => action.intent != VoiceIntent.unknown;
}
