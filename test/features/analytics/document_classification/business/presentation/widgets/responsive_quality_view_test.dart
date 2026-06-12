import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/responsive_quality_view.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/desktop_quality_card.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/mobile_quality_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  Widget buildTestWidget(Size size) {
    return ShadApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: const ResponsiveQualityView(statusText: 'تست'),
          ),
        ),
      ),
    );
  }

  testWidgets('Should render DesktopQualityCard on wide screens',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    await tester.pumpWidget(buildTestWidget(const Size(1200, 800)));
    expect(find.byType(DesktopQualityCard), findsOneWidget);
  });

  testWidgets('Should render MobileQualityCard on small screens',
      (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    await tester.pumpWidget(buildTestWidget(const Size(400, 800)));
    expect(find.byType(MobileQualityCard), findsOneWidget);
  });
}
