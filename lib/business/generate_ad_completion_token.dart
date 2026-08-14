import 'dart:math';

/// Generates a non-guessable token proving a rewarded promo was
/// actually completed (Issue #405, acceptance criterion 4) — without a
/// freshly generated token attached to the log entry, a client can't
/// grant itself access by fabricating an unlock record after the fact.
class GenerateAdCompletionToken {
  static String call() {
    final random = Random.secure();
    return List.generate(16, (_) => random.nextInt(16).toRadixString(16)).join();
  }
}
