import 'dart:convert';

import 'package:share_plus/share_plus.dart';

/// Shares a CSV string via the OS share sheet (Issue #446), mirroring
/// [SharePngBytes]'s PDF/PNG export flow (#117) for a third format.
/// [subject] pre-populates the email subject line (Issue #250);
/// omitted callers keep their previous no-subject behavior.
class ShareCsvBytes {
  static Future<void> call(String csv, String filename, {String? subject}) {
    return SharePlus.instance.share(ShareParams(
      subject: subject,
      files: [XFile.fromData(utf8.encode(csv), mimeType: 'text/csv', name: filename)],
    ));
  }
}
