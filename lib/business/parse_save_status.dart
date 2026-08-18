import 'package:growth_pilot_ai/core/enum/canvas_save_status.dart';
import 'package:growth_pilot_ai/core/models/canvas_bridge_message.dart';

/// Extracts a [CanvasSaveStatus] from an `onSaveStatusChanged`
/// `FlutterBridge` message (Issue #222's "Native Overlays: Save Status
/// indicator") — returns null for any other event or an unrecognized
/// status string.
class ParseSaveStatus {
  static CanvasSaveStatus? call(CanvasBridgeMessage message) {
    if (message.event != 'onSaveStatusChanged') return null;
    switch (message.payload['status']) {
      case 'saving':
        return CanvasSaveStatus.saving;
      case 'saved':
        return CanvasSaveStatus.saved;
      case 'idle':
        return CanvasSaveStatus.idle;
      default:
        return null;
    }
  }
}
