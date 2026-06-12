import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/security/presentation/widgets/security_status_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets(
      'SecurityStatusPage renders flat enterprise guard cards and features',
      (tester) async {
    await tester.pumpWidget(
      const ShadApp(
        home: SecurityStatusPage(),
      ),
    );

    expect(
        find.text('دیتابیس با استاندارد AES-256 رمزنگاری شد'), findsOneWidget);
    expect(find.text('انطباق با PIPEDA'), findsOneWidget);
    expect(find.byType(ShadCard), findsOneWidget);
  });
}
