import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/utils/responsive_helper.dart';

/// Issue #9 — responsive layout testing across the mobile/tablet/desktop
/// breakpoints [ResponsiveHelper] defines (600 / 1024).
void main() {
  Widget hostAt(double width, WidgetBuilder builder) {
    return MediaQuery(
      data: MediaQueryData(size: Size(width, 800)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Builder(builder: builder),
      ),
    );
  }

  testWidgets('classifies a phone width as mobile', (tester) async {
    await tester.pumpWidget(hostAt(375, (context) {
      expect(ResponsiveHelper.isMobile(context), isTrue);
      expect(ResponsiveHelper.isTablet(context), isFalse);
      expect(ResponsiveHelper.isDesktop(context), isFalse);
      return const SizedBox();
    }));
  });

  testWidgets('classifies a tablet width as tablet', (tester) async {
    await tester.pumpWidget(hostAt(800, (context) {
      expect(ResponsiveHelper.isMobile(context), isFalse);
      expect(ResponsiveHelper.isTablet(context), isTrue);
      expect(ResponsiveHelper.isDesktop(context), isFalse);
      return const SizedBox();
    }));
  });

  testWidgets('classifies a desktop width as desktop', (tester) async {
    await tester.pumpWidget(hostAt(1280, (context) {
      expect(ResponsiveHelper.isMobile(context), isFalse);
      expect(ResponsiveHelper.isTablet(context), isFalse);
      expect(ResponsiveHelper.isDesktop(context), isTrue);
      return const SizedBox();
    }));
  });

  testWidgets('the 600 boundary belongs to tablet, not mobile', (tester) async {
    await tester.pumpWidget(hostAt(600, (context) {
      expect(ResponsiveHelper.isMobile(context), isFalse);
      expect(ResponsiveHelper.isTablet(context), isTrue);
      return const SizedBox();
    }));
  });
}
