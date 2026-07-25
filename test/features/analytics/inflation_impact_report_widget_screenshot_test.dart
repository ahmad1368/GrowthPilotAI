import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inflation_impact_report_widget.dart';

TransactionEntity _tx(double amount, {required bool income}) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'x', dbType: income ? 1 : 0);

/// Captures light/dark PNGs of the new Inflation Impact Simulator widget
/// (Issue #373) for QA. Not a golden comparison — it only records the look.
void main() {
  final transactions = [
    _tx(8000, income: true),
    _tx(5000, income: false),
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
            child: InflationImpactReportWidget(
                data: {'transactions': transactions}, title: 'Inflation Impact Simulator'),
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

  testWidgets('writes light and dark inflation-impact screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'inflation_impact_light.png');
    await capture(tester, Brightness.dark, 'inflation_impact_dark.png');
    expect(File('screenshots/inflation_impact_light.png').existsSync(), isTrue);
    expect(File('screenshots/inflation_impact_dark.png').existsSync(), isTrue);
  });
}
