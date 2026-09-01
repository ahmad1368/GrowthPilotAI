import 'package:growth_pilot_ai/core/enum/export_format.dart';

/// Deterministic export filename (Issue #222) — timestamped so repeat
/// exports never collide.
class BuildExportFileName {
  static String call(ExportFormat format, DateTime now) {
    final stamp = now.toIso8601String().replaceAll(RegExp(r'[:.]'), '-');
    final extension = format == ExportFormat.png ? 'png' : 'svg';
    return 'growthpilot-canvas-$stamp.$extension';
  }
}
