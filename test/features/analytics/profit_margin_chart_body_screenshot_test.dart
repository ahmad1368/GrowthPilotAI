import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_chart_body.dart';

TransactionEntity _income(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'in', dbType: 1);
TransactionEntity _expense(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'out', dbType: 0);

/// Captures light/dark PNGs of the new Profit Margin Analysis widget (Issue
/// #350) for QA. Not a golden comparison — it only records the current look.
void main() {
  final transactions = [
    _income(DateTime(2026, 1, 10), 4000),
    _expense(DateTime(2026, 1, 15), 3200),
    _income(DateTime(2026, 2, 10), 4500),
    _expense(DateTime(2026, 2, 15), 2000),
    _income(DateTime(2026, 3, 10), 3800),
    _expense(DateTime(2026, 3, 15), 4600),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(360, 320));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child: ProfitMarginChartBody(transactions: transactions),
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

  testWidgets('writes light and dark profit-margin-chart screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'profit_margin_chart_light.png');
    await capture(tester, Brightness.dark, 'profit_margin_chart_dark.png');
    expect(File('screenshots/profit_margin_chart_light.png').existsSync(),
        isTrue);
    expect(
        File('screenshots/profit_margin_chart_dark.png').existsSync(), isTrue);
  });
}
