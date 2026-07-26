import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_risk_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when no compliance items are tracked', (tester) async {
    await tester.pumpWidget(_wrap(const ComplianceRiskReportWidget(
        data: {'items': <ComplianceItemEntity>[]}, title: 'x')));

    expect(find.text('No compliance items tracked yet.'), findsOneWidget);
  });

  testWidgets('shows a warning icon for an expired item', (tester) async {
    final expired = ComplianceItemEntity(
        name: 'Health Permit', expiryDate: DateTime.now().subtract(const Duration(days: 5)));

    await tester.pumpWidget(_wrap(ComplianceRiskReportWidget(
        data: {'items': [expired]}, title: 'x')));

    expect(find.text('Health Permit'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
    expect(find.text('5d overdue'), findsOneWidget);
  });

  testWidgets('shows the "+ Add Item" quick-add button', (tester) async {
    await tester.pumpWidget(_wrap(const ComplianceRiskReportWidget(
        data: {'items': <ComplianceItemEntity>[]}, title: 'x')));

    expect(find.text('+ Add Item'), findsOneWidget);
  });
}
