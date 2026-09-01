import 'package:flutter/foundation.dart';

/// Web-safe platform label for the consent audit log (Issue #215) — no
/// `dart:io Platform` (unavailable on web); [defaultTargetPlatform] +
/// [kIsWeb] work on every supported build target.
class CurrentClientPlatformLabel {
  static String call() {
    if (kIsWeb) return 'Web';
    return defaultTargetPlatform.name;
  }
}
