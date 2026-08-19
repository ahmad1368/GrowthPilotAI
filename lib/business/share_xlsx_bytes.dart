import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

/// Shares generated `.xlsx` bytes via the OS share sheet (Issue #245),
/// mirroring [ShareCsvBytes]'s export flow for a fourth format.
/// [subject] pre-populates the email subject line (Issue #250).
class ShareXlsxBytes {
  static Future<void> call(List<int> bytes, String filename, {String? subject}) {
    return SharePlus.instance.share(ShareParams(subject: subject, files: [
      XFile.fromData(Uint8List.fromList(bytes),
          mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', name: filename),
    ]));
  }
}
