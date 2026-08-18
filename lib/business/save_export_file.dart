import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

/// Saves exported canvas bytes to local storage (Issue #222's "File
/// Management"). Web has no local filesystem to write to — [call]
/// returns null there; use [ShareExportFile] instead, which works on
/// every platform via in-memory bytes.
class SaveExportFile {
  static Future<File?> call(Uint8List bytes, String fileName) async {
    if (kIsWeb) return null;
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    return file.writeAsBytes(bytes);
  }
}
