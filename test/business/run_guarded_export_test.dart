import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/run_guarded_export.dart';

void main() {
  group('RunGuardedExport', () {
    test('sets busy true while running and false once complete', () async {
      final isBusy = false.obs;
      final completer = Completer<void>();

      final future = RunGuardedExport.call(isBusy, 'XLSX', 'test', () => completer.future);
      expect(isBusy.value, isTrue);

      completer.complete();
      await future;
      expect(isBusy.value, isFalse);
    });

    test('ignores a second call while already busy', () async {
      var callCount = 0;
      final isBusy = false.obs;
      final completer = Completer<void>();

      final first = RunGuardedExport.call(isBusy, 'XLSX', 'test', () {
        callCount++;
        return completer.future;
      });

      await RunGuardedExport.call(isBusy, 'XLSX', 'test', () {
        callCount++;
        return Future.value();
      });
      expect(callCount, 1);

      completer.complete();
      await first;
    });

    testWidgets('resets busy to false and does not rethrow when the action throws', (tester) async {
      await tester.pumpWidget(GetMaterialApp(home: Container()));

      final isBusy = false.obs;
      await RunGuardedExport.call(isBusy, 'XLSX', 'test', () async => throw Exception('boom'));

      expect(isBusy.value, isFalse);

      // Let the snackbar's own auto-dismiss timer finish so no pending
      // Timer trips flutter_test's leak-detection assertion at teardown.
      await tester.pump(const Duration(seconds: 4));
    });
  });
}
