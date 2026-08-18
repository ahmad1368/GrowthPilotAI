import 'package:flutter/foundation.dart';

/// One Web-to-Flutter message over the `FlutterBridge` JS channel (Issue
/// #220) — mirrors the issue's own event shape (e.g. `onNodeDoubleClick`
/// with a payload of the clicked node's data).
@immutable
class CanvasBridgeMessage {
  final String event;
  final Map<String, dynamic> payload;

  const CanvasBridgeMessage({required this.event, required this.payload});
}
