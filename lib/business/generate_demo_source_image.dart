import 'dart:typed_data';
import 'package:image/image.dart' as img;

/// Procedurally generates a large synthetic "photo" so the image
/// optimization demo (Issue #139) has something to process without
/// needing a real upload picker UI — that's a separate issue, #140.
class GenerateDemoSourceImage {
  static Uint8List call({int size = 1200}) {
    final image = img.Image(width: size, height: size);
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        image.setPixelRgb(x, y, x * 255 ~/ size, y * 255 ~/ size, 128);
      }
    }
    return Uint8List.fromList(img.encodePng(image));
  }
}
