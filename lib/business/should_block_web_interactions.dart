/// "Platform Guard" (Issue #263): the blocking offline overlay is a Web-
/// only behavior — Mobile instead degrades gracefully to local-first
/// processing (already this app's default via ObjectBox), so it must
/// never show this overlay.
class ShouldBlockWebInteractions {
  static bool call({required bool isWeb, required bool isOnline}) => isWeb && !isOnline;
}
