import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/holiday_impact_report_widget.dart';

TransactionEntity _income(DateTime date, double amount) =>
    TransactionEntity(amount: amount, date: date, description: 'x', dbType: 1);

/// Captures light/dark PNGs of the new Holiday Sales Impact widget (Issue
/// #388) for QA. Not a golden comparison — it only records the look.
void main() {
  final transactions = [
    for (var d = 1; d <= 10; d++) _income(DateTime(2026, 3, d), 10),
    _income(DateTime(2026, 7, 1), 400),
    _income(DateTime(2026, 12, 25), 50),
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
            child: HolidayImpactReportWidget(
                data: {'transactions': transactions}, title: 'Holiday Sales Impact'),
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

  testWidgets('writes light and dark holiday-impact screenshots', (tester) async {
    await capture(tester, Brightness.light, 'holiday_impact_light.png');
    await capture(tester, Brightness.dark, 'holiday_impact_dark.png');
    expect(File('screenshots/holiday_impact_light.png').existsSync(), isTrue);
    expect(File('screenshots/holiday_impact_dark.png').existsSync(), isTrue);
  });
}
