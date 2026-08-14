import 'dart:math';

/// Exponential backoff delay before retrying a failed dispatch (Issue
/// #406, acceptance criterion 3) — doubles per attempt, capped at one
/// hour so a struggling task doesn't drift arbitrarily far out.
class ComputeRetryBackoff {
  static const _capMinutes = 60;

  static Duration call(int attemptNumber) {
    final minutes = min(_capMinutes, pow(2, attemptNumber).toInt());
    return Duration(minutes: minutes);
  }
}
