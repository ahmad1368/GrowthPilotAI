/// The placeholder assistant reply (Issue #200) — no real on-device
/// inference exists yet (see #196-#199's PR notes), so this text makes
/// that explicit instead of pretending to answer the user's question.
class BuildStubAssistantReply {
  static String call() =>
      "On-device AI inference isn't available in this build yet. "
      'This response is a placeholder demonstrating the streaming chat interface.';
}
