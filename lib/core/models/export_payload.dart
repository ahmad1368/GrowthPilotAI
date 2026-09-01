import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/export_format.dart';

/// A captured canvas export, received from the WebView over the
/// `FlutterBridge` (Issue #222) — [base64Data] is the raw image bytes,
/// base64-encoded by the JS side before crossing the bridge.
@immutable
class ExportPayload {
  final ExportFormat format;
  final String base64Data;

  const ExportPayload({required this.format, required this.base64Data});
}
