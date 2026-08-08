import 'dart:typed_data';
import 'package:image/image.dart' as img;

typedef ImageVariants = ({Uint8List thumbnail, Uint8List standard, int originalSizeBytes});

/// Resizes a source image into a thumbnail (200x200, cropped square)
/// and a "Standard" variant capped at 800px on the long edge (Issue
/// #139, "Triple-Stream Logic"). The `image` package can only decode
/// WebP, not encode it — there's no pure-Dart WebP encoder without
/// native bindings — so this re-encodes as JPEG for a genuine
/// byte-size reduction instead of a fake "WebP" label.
class GenerateImageVariants {
  static ImageVariants call(Uint8List originalBytes) {
    final decoded = img.decodeImage(originalBytes)!;
    final thumb = img.copyResize(decoded, width: 200, height: 200, maintainAspect: true);
    final standardSrc = decoded.width > 800 ? img.copyResize(decoded, width: 800) : decoded;
    return (
      thumbnail: Uint8List.fromList(img.encodeJpg(thumb, quality: 70)),
      standard: Uint8List.fromList(img.encodeJpg(standardSrc, quality: 85)),
      originalSizeBytes: originalBytes.length,
    );
  }
}
