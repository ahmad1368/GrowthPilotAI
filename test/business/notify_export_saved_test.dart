import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/notify_export_saved.dart';

void main() {
  group('NotifyExportSaved', () {
    testWidgets('completes without throwing even when the Downloads write is unavailable', (tester) async {
      await tester.pumpWidget(GetMaterialApp(home: Container()));

      // No path_provider platform implementation is registered in the
      // test environment, so SaveExportBytesToDownloads is expected to
      // fail internally; this call must still complete normally.
      await NotifyExportSaved.call(Uint8List.fromList([1, 2, 3]), 'report.pdf');

      await tester.pump(const Duration(seconds: 4));
    });
  });
}
