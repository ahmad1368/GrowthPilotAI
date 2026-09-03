import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/cleanup_temp_receipt_image.dart';

void main() {
  group('CleanupTempReceiptImage (Issue #21 AC - Data Hygiene)', () {
    test('deletes an existing temp file', () async {
      final file = File(
          '${Directory.systemTemp.path}/cleanup_temp_receipt_image_test_${DateTime.now().microsecondsSinceEpoch}.jpg');
      await file.writeAsBytes([1, 2, 3]);
      expect(await file.exists(), isTrue);

      await CleanupTempReceiptImage.call(file);

      expect(await file.exists(), isFalse);
    });

    test('does not throw when the file is already gone', () async {
      final file = File(
          '${Directory.systemTemp.path}/cleanup_temp_receipt_image_test_missing_${DateTime.now().microsecondsSinceEpoch}.jpg');
      expect(await file.exists(), isFalse);

      await expectLater(CleanupTempReceiptImage.call(file), completes);
    });
  });
}
