import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/store_profile_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/space_productivity_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

TransactionEntity _income(double amount) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'sale', dbType: 1);

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when no square footage has been set', (tester) async {
    await tester.pumpWidget(_wrap(SpaceProductivityReportWidget(
        data: {
          'transactions': [_income(1000)],
          'storeProfile': StoreProfileEntity(squareFootage: 0),
        },
        title: 'x')));

    expect(find.text('Set your store\'s square footage to see this index.'), findsOneWidget);
  });

  testWidgets('shows the revenue-per-square-foot badge once square footage is set',
      (tester) async {
    await tester.pumpWidget(_wrap(SpaceProductivityReportWidget(
        data: {
          'transactions': [_income(1000)],
          'storeProfile': StoreProfileEntity(squareFootage: 100),
        },
        title: 'x')));

    expect(find.text('Floor Space'), findsOneWidget);
    expect(find.text('100 sq ft'), findsOneWidget);
  });

  testWidgets('shows the "Set Sq Ft" quick-edit button', (tester) async {
    await tester.pumpWidget(_wrap(SpaceProductivityReportWidget(
        data: {
          'transactions': const <TransactionEntity>[],
          'storeProfile': StoreProfileEntity(squareFootage: 0),
        },
        title: 'x')));

    expect(find.text('Set Sq Ft'), findsOneWidget);
  });
}
