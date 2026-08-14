/// "Tap to Confirm" state machine (Issue #154 UX Safety AC) — every
/// voice command sits in [awaitingConfirmation] until the human taps.
enum VoiceCommandStatus { intentParsed, awaitingConfirmation, confirmed, canceled }
