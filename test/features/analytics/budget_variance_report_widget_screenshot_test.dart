import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

/// Captures light/dark PNGs of the new Budget Variance Alert widget (Issue
/// #383) for QA. Not a golden comparison — it only records the look.
void main() {
  final rent = CategoryEntity(name: 'Rent');
  final marketing = CategoryEntity(name: 'Marketing');
  final now = DateTime.now().subtract(const Duration(days: 2));
  final transactions = [
    _expense(1200, now, rent),
    _expense(300, now, marketing),
  ];
  final limits = [
    BudgetLimitEntity(categoryName: 'Rent', monthlyLimit: 1000),
    BudgetLimitEntity(categoryName: 'Marketing', monthlyLimit: 500),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 420));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: bg,
              padding: const EdgeInsets.all(12),
              child: BudgetVarianceReportWidget(
                  data: {'transactions': transactions, 'limits': limits},
                  title: 'Budget Variance Alerts'),
            ),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      Directory('screenshots').createSync(recursive: true);
      File('screenshots/$file').writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  testWidgets('writes light and dark budget-variance screenshots', (tester) async {
    await capture(tester, Brightness.light, 'budget_variance_light.png');
    await capture(tester, Brightness.dark, 'budget_variance_dark.png');
    expect(File('screenshots/budget_variance_light.png').existsSync(), isTrue);
    expect(File('screenshots/budget_variance_dark.png').existsSync(), isTrue);
  });
}
