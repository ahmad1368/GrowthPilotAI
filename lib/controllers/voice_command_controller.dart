import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_voice_confirmation_summary.dart';
import 'package:growth_pilot_ai/business/extract_voice_command_action.dart';
import 'package:growth_pilot_ai/business/is_voice_command_executable.dart';
import 'package:growth_pilot_ai/core/enum/voice_command_status.dart';
import 'package:growth_pilot_ai/core/models/voice_command_action.dart';

/// "Voice-to-Action Pipeline" (Issue #154) state, starting from an
/// already-transcribed string — audio capture/Whisper/on-device STT are
/// not wired up here; see the PR notes for that follow-up.
class VoiceCommandController extends GetxController {
  final pendingAction = Rx<VoiceCommandAction?>(null);
  final status = Rx<VoiceCommandStatus?>(null);
  final confirmationSummary = ''.obs;

  void onTranscript(String transcript, {String? screenContext}) {
    final action = ExtractVoiceCommandAction.call(transcript, screenContext: screenContext);
    pendingAction.value = action;
    confirmationSummary.value = BuildVoiceConfirmationSummary.call(action);
    status.value = VoiceCommandStatus.awaitingConfirmation;
  }

  bool confirm() {
    final action = pendingAction.value;
    if (action == null || !IsVoiceCommandExecutable.call(action)) return false;
    status.value = VoiceCommandStatus.confirmed;
    return true;
  }

  void cancel() {
    status.value = VoiceCommandStatus.canceled;
    pendingAction.value = null;
    confirmationSummary.value = '';
  }
}
