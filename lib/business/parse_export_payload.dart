import 'package:growth_pilot_ai/core/enum/export_format.dart';
import 'package:growth_pilot_ai/core/models/canvas_bridge_message.dart';
import 'package:growth_pilot_ai/core/models/export_payload.dart';

/// Extracts an [ExportPayload] from an `onExportReady` `FlutterBridge`
/// message (Issue #222) — returns null for any other event or an
/// unrecognized/missing format.
class ParseExportPayload {
  static ExportPayload? call(CanvasBridgeMessage message) {
    if (message.event != 'onExportReady') return null;
    final data = message.payload['data'];
    if (data is! String) return null;

    final format = switch (message.payload['format']) {
      'png' => ExportFormat.png,
      'svg' => ExportFormat.svg,
      _ => null,
    };
    if (format == null) return null;

    return ExportPayload(format: format, base64Data: data);
  }
}
