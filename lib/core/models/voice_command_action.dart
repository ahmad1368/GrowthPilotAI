import 'package:growth_pilot_ai/core/enum/voice_intent.dart';

/// A parsed voice command, ready for the "Tap to Confirm" step (Issue
/// #154) — [title]/[price] populate `CREATE_ASSET`, [messageBody]
/// populates `SEND_MESSAGE`; both stay null for other intents.
typedef VoiceCommandAction = ({
  VoiceIntent intent,
  String transcript,
  String? title,
  double? price,
  String? messageBody,
});
