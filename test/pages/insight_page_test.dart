import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/transaction_controller.dart';
import 'package:growth_pilot_ai/pages/insight_page.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    // TransactionController.onInit() catches its own ObjectBox lookup
    // failure internally, so it's safe to construct without a real DB here.
    Get.put(TransactionController());
  });

  tearDown(() {
    Get.reset();
  });

  Future<void> pumpInsightPage(WidgetTester tester, {required EdgeInsets viewPadding}) async {
    await tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(padding: viewPadding),
        child: const MaterialApp(home: InsightPage(title: 'Insights')),
      ),
    );
  }

  group('InsightPage safe-area padding (Issue #9)', () {
    testWidgets('header top padding grows with a larger MediaQuery.padding.top (notch)', (tester) async {
      await pumpInsightPage(tester, viewPadding: EdgeInsets.zero);
      final basePadding = tester.widget<Padding>(find.byType(Padding).first).padding as EdgeInsets;

      await pumpInsightPage(tester, viewPadding: const EdgeInsets.only(top: 47));
      final notchPadding = tester.widget<Padding>(find.byType(Padding).first).padding as EdgeInsets;

      expect(notchPadding.top, greaterThan(basePadding.top));
      expect(notchPadding.top - basePadding.top, 47);
    });

    testWidgets('list bottom padding grows with a larger MediaQuery.padding.bottom (gesture bar)', (tester) async {
      await pumpInsightPage(tester, viewPadding: EdgeInsets.zero);
      final baseSliverPadding =
          tester.widget<SliverPadding>(find.byType(SliverPadding)).padding as EdgeInsets;

      await pumpInsightPage(tester, viewPadding: const EdgeInsets.only(bottom: 34));
      final gesturePadding =
          tester.widget<SliverPadding>(find.byType(SliverPadding)).padding as EdgeInsets;

      expect(gesturePadding.bottom, greaterThan(baseSliverPadding.bottom));
      expect(gesturePadding.bottom - baseSliverPadding.bottom, 34);
    });
  });
}
