import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:growth_pilot_ai/business/detect_performance_tier.dart';
import 'package:growth_pilot_ai/core/enum/performance_tier.dart';

/// Reads the one hardware signal available on every native platform —
/// CPU core count — to classify the device (Issue #110). `dart:io` has no
/// web implementation, and the browser exposes no reliable hardware specs
/// without a native plugin, so web always gets the safe [PerformanceTier
/// .mid] default rather than a native call that would break `flutter
/// build web`.
class PerformanceTierService {
  static PerformanceTier detect() {
    if (kIsWeb) return PerformanceTier.mid;
    return DetectPerformanceTier.call(Platform.numberOfProcessors);
  }
}
