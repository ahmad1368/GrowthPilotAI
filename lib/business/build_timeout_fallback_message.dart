/// The user-facing message shown when [IsInferenceTimeout] fires (Issue
/// #210's "Fallback UI"), verbatim from the issue's own spec.
class BuildTimeoutFallbackMessage {
  static String call() =>
      'The AI is taking longer than usual. Would you like to continue waiting or try a simpler question?';
}
