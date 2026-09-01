import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/annual_profit_forecast_report_widget.dart';

TransactionEntity _tx(double amount, DateTime date, {required bool income}) =>
    TransactionEntity(
        amount: amount, date: date, description: 'x', dbType: income ? 1 : 0);

/// Captures light/dark PNGs of the new Annual Profit Forecast widget
/// (Issue #399) for QA. Not a golden comparison — it only records the look.
void main() {
  final transactions = [
    _tx(5000, DateTime(2025, 11, 10), income: true),
    _tx(2000, DateTime(2025, 11, 10), income: false),
    _tx(5500, DateTime(2025, 12, 10), income: true),
    _tx(2100, DateTime(2025, 12, 10), income: false),
    _tx(6000, DateTime(2026, 1, 10), income: true),
    _tx(2200, DateTime(2026, 1, 10), income: false),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 320));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child: AnnualProfitForecastReportWidget(
                data: {'transactions': transactions}, title: 'Annual Profit Forecast'),
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

  testWidgets('writes light and dark annual-profit-forecast screenshots', (tester) async {
    await capture(tester, Brightness.light, 'annual_profit_forecast_light.png');
    await capture(tester, Brightness.dark, 'annual_profit_forecast_dark.png');
    expect(File('screenshots/annual_profit_forecast_light.png').existsSync(), isTrue);
    expect(File('screenshots/annual_profit_forecast_dark.png').existsSync(), isTrue);
  });
}
