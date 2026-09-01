import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_directory_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when no suppliers are added', (tester) async {
    await tester.pumpWidget(_wrap(const SupplierDirectoryReportWidget(
        data: {'vendors': <VendorEntity>[]}, title: 'x')));

    expect(find.text('No suppliers added yet.'), findsOneWidget);
  });

  testWidgets('shows the supplier name, contact info, and payment terms', (tester) async {
    final vendor = VendorEntity(
        name: 'Acme Supplies', contactInfo: '555-1234', paymentTerms: 'Net 30');

    await tester.pumpWidget(_wrap(SupplierDirectoryReportWidget(
        data: {'vendors': [vendor]}, title: 'x')));

    expect(find.text('Acme Supplies'), findsOneWidget);
    expect(find.textContaining('555-1234'), findsOneWidget);
    expect(find.textContaining('Net 30'), findsOneWidget);
  });

  testWidgets('shows Archived for an inactive supplier and an Archive/Restore toggle',
      (tester) async {
    final active = VendorEntity(name: 'Active Co', isActive: true);
    final archived = VendorEntity(name: 'Archived Co', isActive: false);

    await tester.pumpWidget(_wrap(SupplierDirectoryReportWidget(
        data: {'vendors': [active, archived]}, title: 'x')));

    expect(find.text('Archived Co'), findsOneWidget);
    expect(find.textContaining('Archived'), findsNWidgets(2));
    expect(find.text('Archive'), findsOneWidget);
    expect(find.text('Restore'), findsOneWidget);
  });

  testWidgets('shows the "+ Supplier" quick-add button', (tester) async {
    await tester.pumpWidget(_wrap(const SupplierDirectoryReportWidget(
        data: {'vendors': <VendorEntity>[]}, title: 'x')));

    expect(find.text('+ Supplier'), findsOneWidget);
  });
}
