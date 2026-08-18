import 'dart:convert';
import 'package:growth_pilot_ai/core/models/canvas_bridge_message.dart';

/// Parses one raw JSON string received on the `FlutterBridge` JS channel
/// (Issue #220) — returns null on malformed input instead of throwing,
/// since this is untrusted content from a WebView page.
class ParseFlutterBridgeMessage {
  static CanvasBridgeMessage? call(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      final event = decoded['event'];
      if (event is! String) return null;
      final payload = decoded['payload'];
      return CanvasBridgeMessage(
          event: event, payload: payload is Map<String, dynamic> ? payload : const {});
    } catch (_) {
      return null;
    }
  }
}
