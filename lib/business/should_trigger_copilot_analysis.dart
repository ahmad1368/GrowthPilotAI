/// "Only trigger AI analysis if the user is Active in the chat, to save
/// on API tokens" (Issue #152 Cost Management constraint).
class ShouldTriggerCopilotAnalysis {
  static bool call({required bool isUserActiveInChat}) => isUserActiveInChat;
}
