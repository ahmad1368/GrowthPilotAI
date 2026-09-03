import 'dart:io';

import 'package:flutter/painting.dart' show Size;
import 'package:image/image.dart' as img;

/// Reads a receipt image's pixel dimensions so the scanning overlay's
/// bounding-box painter (Issue #26) can scale ML Kit's coordinates — given
/// in the original image's pixel space — onto the screen's logical pixels.
class OcrImageSizeReader {
  static Future<Size> read(File imageFile) async {
    final decoded = img.decodeImage(await imageFile.readAsBytes());
    if (decoded == null) return Size.zero;
    return Size(decoded.width.toDouble(), decoded.height.toDouble());
  }
}
