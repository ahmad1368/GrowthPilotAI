import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

/// "Automatically saved to the device's Downloads folder... accessible
/// later from the file manager, outside the app" (Issue #255) — writes
/// straight to the OS's real public Downloads directory via
/// `path_provider`'s scoped-storage-safe `getDownloadsDirectory()`
/// (Android; no broad storage permission needed on modern Android,
/// matching the issue's own "avoid Play Store rejection" note).
/// Returns null wherever there's no public Downloads concept (Web,
/// iOS — see PR notes for the iOS "Save to Files" fallback already
/// covered by this repo's existing `Share*Bytes` helpers).
class SaveExportBytesToDownloads {
  static Future<File?> call(Uint8List bytes, String filename) async {
    if (kIsWeb) return null;
    final directory = await getDownloadsDirectory();
    if (directory == null) return null;
    final file = File('${directory.path}/$filename');
    return file.writeAsBytes(bytes);
  }
}
