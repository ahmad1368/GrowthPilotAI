import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/budget_variance_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

TransactionEntity _expense(double amount, DateTime date, CategoryEntity category) {
  final tx =
      TransactionEntity(amount: amount, date: date, description: 'x', dbType: 0);
  tx.category.target = category;
  return tx;
}

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when no limits are configured', (tester) async {
    await tester.pumpWidget(_wrap(const BudgetVarianceReportWidget(
        data: {
          'transactions': <TransactionEntity>[],
          'limits': <BudgetLimitEntity>[],
        },
        title: 'x')));

    expect(find.text('No budget limits configured yet.'), findsOneWidget);
  });

  testWidgets('shows a warning icon for a category over its limit', (tester) async {
    final rent = CategoryEntity(name: 'Rent');
    final now = DateTime.now().subtract(const Duration(days: 2));

    await tester.pumpWidget(_wrap(BudgetVarianceReportWidget(
        data: {
          'transactions': [_expense(1200, now, rent)],
          'limits': [BudgetLimitEntity(categoryName: 'Rent', monthlyLimit: 1000)],
        },
        title: 'x')));

    expect(find.text('Rent'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
  });

  testWidgets('shows the "+ Set Limit" quick-configure button', (tester) async {
    await tester.pumpWidget(_wrap(const BudgetVarianceReportWidget(
        data: {
          'transactions': <TransactionEntity>[],
          'limits': <BudgetLimitEntity>[],
        },
        title: 'x')));

    expect(find.text('+ Set Limit'), findsOneWidget);
  });
}
