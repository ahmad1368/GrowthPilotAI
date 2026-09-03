import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_spatial_sorter.dart';

TextBlock _block(String text, {required double top, required double left}) {
  return TextBlock(
    text: text,
    lines: const [],
    boundingBox: Rect.fromLTWH(left, top, 40, 12),
    recognizedLanguages: const [],
    cornerPoints: const [],
  );
}

void main() {
  group('OCRSpatialSorter (Issue #22 AC)', () {
    test('Row Integrity: item name and price on the same row end up adjacent',
        () {
      final data = RecognizedText(text: '', blocks: [
        _block('Total', top: 200, left: 10),
        _block('Vendor', top: 0, left: 10),
        _block('\$15.50', top: 200, left: 120),
      ]);

      final sorted = OCRSpatialSorter.sort(data);

      expect(sorted.map((b) => b.text), ['Vendor', 'Total', '\$15.50']);
    });

    test('Top-to-Bottom Flow: vendor name precedes the total amount', () {
      final data = RecognizedText(text: '', blocks: [
        _block('Total: \$42.00', top: 300, left: 10),
        _block('Acme Store', top: 5, left: 10),
      ]);

      final sorted = OCRSpatialSorter.sort(data);

      expect(sorted.first.text, 'Acme Store');
      expect(sorted.last.text, 'Total: \$42.00');
    });

    test(
        'Tolerance Threshold: blocks within the 15px shake tolerance stay grouped by row',
        () {
      final data = RecognizedText(text: '', blocks: [
        _block('Qty', top: 108, left: 10),
        _block('Item', top: 100, left: 60),
        _block('Price', top: 112, left: 150),
      ]);

      final sorted = OCRSpatialSorter.sort(data);

      expect(sorted.map((b) => b.text), ['Qty', 'Item', 'Price']);
    });

    test('does not mutate text content while sorting', () {
      final data = RecognizedText(text: '', blocks: [
        _block('B', top: 50, left: 10),
        _block('A', top: 0, left: 10),
      ]);

      final sorted = OCRSpatialSorter.sort(data);

      expect(sorted.map((b) => b.text).toSet(), {'A', 'B'});
    });
  });
}
