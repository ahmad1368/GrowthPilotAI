import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/overhead_report_widget.dart';

TransactionEntity _tx(double amount, {required bool income, CategoryEntity? category}) {
  final tx = TransactionEntity(
      amount: amount, date: DateTime(2026, 1, 1), description: 'x', dbType: income ? 1 : 0);
  if (category != null) tx.category.target = category;
  return tx;
}

/// Captures light/dark PNGs of the new Operating Expense & Overhead widget
/// (Issue #367) for QA. Not a golden comparison — it only records the look.
void main() {
  final rent = CategoryEntity(name: 'Rent');
  final utilities = CategoryEntity(name: 'Utilities');
  final insurance = CategoryEntity(name: 'Insurance');
  final transactions = [
    _tx(5000, income: true),
    _tx(1000, income: false, category: rent), // 20%, over budget
    _tx(400, income: false, category: utilities), // 8%
    _tx(200, income: false, category: insurance), // 4%
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
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child: OverheadReportWidget(
                data: {'transactions': transactions},
                title: 'Operating Expense & Overhead'),
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

  testWidgets('writes light and dark overhead-widget screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'overhead_analysis_light.png');
    await capture(tester, Brightness.dark, 'overhead_analysis_dark.png');
    expect(File('screenshots/overhead_analysis_light.png').existsSync(), isTrue);
    expect(File('screenshots/overhead_analysis_dark.png').existsSync(), isTrue);
  });
}
