import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_profitability_report_widget.dart';

TransactionEntity _tx(double amount, {required bool income, CategoryEntity? category}) {
  final tx = TransactionEntity(
      amount: amount, date: DateTime.now(), description: 'x', dbType: income ? 1 : 0);
  if (category != null) tx.category.target = category;
  return tx;
}

/// Captures light/dark PNGs of the new Item/Service-Level Profitability
/// Breakdown widget (Issue #361) for QA. Not a golden comparison — it only
/// records the current look.
void main() {
  final consulting = CategoryEntity(name: 'Consulting');
  final retail = CategoryEntity(name: 'Retail Goods');
  final overhead = CategoryEntity(name: 'Overhead');
  final transactions = [
    _tx(5000, income: true, category: consulting),
    _tx(800, income: false, category: consulting),
    _tx(1200, income: true, category: retail),
    _tx(1000, income: false, category: retail),
    _tx(600, income: false, category: overhead),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 260));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child: CategoryProfitabilityReportWidget(
                data: {'transactions': transactions}, title: 'Profitability by Category'),
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

  testWidgets('writes light and dark category-profitability screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'category_profitability_light.png');
    await capture(tester, Brightness.dark, 'category_profitability_dark.png');
    expect(
        File('screenshots/category_profitability_light.png').existsSync(),
        isTrue);
    expect(
        File('screenshots/category_profitability_dark.png').existsSync(),
        isTrue);
  });
}
