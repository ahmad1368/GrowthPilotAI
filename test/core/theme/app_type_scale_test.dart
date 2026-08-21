import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/theme/app_type_scale.dart';

void main() {
  group('AppTypeScale', () {
    Future<double> heading1SizeAt(WidgetTester tester, double width) async {
      late double size;
      await tester.pumpWidget(MediaQuery(
        data: MediaQueryData(size: Size(width, 800)),
        child: Builder(builder: (context) {
          size = AppTypeScale.heading1(context).fontSize!;
          return const SizedBox();
        }),
      ));
      return size;
    }

    testWidgets('uses the mobile heading1 size below the tablet breakpoint (Issue #175 AC)', (tester) async {
      expect(await heading1SizeAt(tester, 375), 24);
    });

    testWidgets('uses the wide heading1 size at/above the tablet breakpoint (Issue #175 AC)', (tester) async {
      expect(await heading1SizeAt(tester, 1024), 32);
    });

    testWidgets('preserves weight and line-height ratio across breakpoints', (tester) async {
      late TextStyle mobile;
      late TextStyle wide;
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(375, 800)),
        child: Builder(builder: (context) {
          mobile = AppTypeScale.heading1(context);
          return const SizedBox();
        }),
      ));
      await tester.pumpWidget(MediaQuery(
        data: const MediaQueryData(size: Size(1024, 800)),
        child: Builder(builder: (context) {
          wide = AppTypeScale.heading1(context);
          return const SizedBox();
        }),
      ));

      expect(mobile.fontWeight, wide.fontWeight);
      expect(mobile.height, wide.height);
      expect(mobile.fontSize, isNot(wide.fontSize));
    });
  });
}
