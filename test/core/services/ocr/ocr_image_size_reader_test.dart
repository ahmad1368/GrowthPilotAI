import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_image_size_reader.dart';
import 'package:image/image.dart' as img;

/// Covers Issue #26's image-size lookup — the scanning overlay's
/// bounding-box painter needs the receipt's real pixel dimensions to scale
/// ML Kit's coordinates onto the screen.
void main() {
  test('reads the pixel dimensions of a real image file', () async {
    final image = img.Image(width: 40, height: 25);
    final bytes = Uint8List.fromList(img.encodePng(image));
    final file = await File(
            '${Directory.systemTemp.path}/ocr_image_size_reader_test.png')
        .writeAsBytes(bytes);

    final size = await OcrImageSizeReader.read(file);

    expect(size, const Size(40, 25));
    await file.delete();
  });

  test('returns Size.zero for a file that is not a decodable image', () async {
    final file = await File(
            '${Directory.systemTemp.path}/ocr_image_size_reader_not_image.txt')
        .writeAsBytes(Uint8List.fromList('not an image'.codeUnits));

    final size = await OcrImageSizeReader.read(file);

    expect(size, Size.zero);
    await file.delete();
  });
}
