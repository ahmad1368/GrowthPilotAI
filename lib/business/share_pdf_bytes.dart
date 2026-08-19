import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

/// Shares generated PDF bytes via the OS share sheet, mirroring
/// [ShareXlsxBytes]'s/[ShareCsvBytes]'s export flow for a fifth format
/// (Issue #251's "Direct Download... share via the system's Share
/// Intent" step, done locally instead of downloading from a server URL
/// via `dio`; see PR notes). [subject] pre-populates the email subject
/// line (mirrors Issue #250).
class SharePdfBytes {
  static Future<void> call(Uint8List bytes, String filename, {String? subject}) {
    return SharePlus.instance.share(ShareParams(
      subject: subject,
      files: [XFile.fromData(bytes, mimeType: 'application/pdf', name: filename)],
    ));
  }
}
