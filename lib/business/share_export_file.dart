import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';
import 'package:growth_pilot_ai/core/enum/export_format.dart';

/// Shares exported canvas bytes via the OS share sheet (Issue #222's
/// "File Management") — `XFile.fromData` builds an in-memory file, so
/// this works on Mobile and Web alike without needing a real path on
/// disk first.
class ShareExportFile {
  static Future<void> call(Uint8List bytes, ExportFormat format, String fileName) {
    final mimeType = format == ExportFormat.png ? 'image/png' : 'image/svg+xml';
    final file = XFile.fromData(bytes, name: fileName, mimeType: mimeType);
    return SharePlus.instance.share(ShareParams(files: [file])).then((_) {});
  }
}
