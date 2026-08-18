import 'package:flutter/foundation.dart';

/// A document the user selected on-device (Issue #225's "File Picker"
/// step) — [path] is null on Web, where only in-memory [bytes] are
/// available.
@immutable
class PickedDocument {
  final String fileName;
  final int sizeBytes;
  final String? path;
  final Uint8List? bytes;

  const PickedDocument({
    required this.fileName,
    required this.sizeBytes,
    this.path,
    this.bytes,
  });

  String get extension => fileName.contains('.') ? fileName.split('.').last.toLowerCase() : '';
}
