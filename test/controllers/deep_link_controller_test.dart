import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/deep_link_controller.dart';

void main() {
  group('DeepLinkController', () {
    testWidgets('starts without throwing even when no app_links platform implementation is registered',
        (tester) async {
      await tester.pumpWidget(GetMaterialApp(home: Container()));

      // No app_links platform implementation is registered in the test
      // environment, so getInitialLink()/uriLinkStream are expected to
      // fail internally; onInit must still complete normally rather
      // than crash app startup.
      expect(() => Get.put(DeepLinkController()), returnsNormally);

      await tester.pump(const Duration(seconds: 1));
    });
  });
}
