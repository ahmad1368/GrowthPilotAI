import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

/// Shares raw PNG bytes via the OS share sheet (Issue #117).
class SharePngBytes {
  static Future<void> call(Uint8List bytes, String filename) {
    return SharePlus.instance.share(ShareParams(
      files: [XFile.fromData(bytes, mimeType: 'image/png', name: filename)],
    ));
  }
}
