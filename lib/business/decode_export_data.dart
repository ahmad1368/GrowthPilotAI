import 'dart:convert';
import 'dart:typed_data';

/// Decodes the base64 image payload crossing the `FlutterBridge` (Issue
/// #222) into raw bytes ready to write to disk or hand to `share_plus`.
class DecodeExportData {
  static Uint8List call(String base64Data) => base64Decode(base64Data);
}
