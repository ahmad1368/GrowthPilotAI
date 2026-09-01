import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

/// Shares generated `.zip` bytes via the OS share sheet (Issue #258),
/// mirroring [ShareXlsxBytes]'s export flow for the batch bundle.
/// [subject] pre-populates the email subject line (Issue #250).
class ShareZipBytes {
  static Future<void> call(List<int> bytes, String filename, {String? subject}) {
    return SharePlus.instance.share(ShareParams(
        subject: subject, files: [XFile.fromData(Uint8List.fromList(bytes), mimeType: 'application/zip', name: filename)]));
  }
}
