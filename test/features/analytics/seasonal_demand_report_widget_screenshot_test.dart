import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_demand_report_widget.dart';

TransactionEntity _income(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'in', dbType: 1);

/// Captures light/dark PNGs of the new Seasonal Demand widget (Issue #352)
/// for QA. Not a golden comparison — it only records the current look.
void main() {
  final transactions = [
    for (var m = 1; m <= 12; m++)
      _income(DateTime(2026, m, 5), m == 12 ? 9000 : 1000.0 + m * 100),
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
            child: SeasonalDemandReportWidget(
                data: {'transactions': transactions}, title: 'Seasonal Demand'),
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

  testWidgets('writes light and dark seasonal-demand screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'seasonal_demand_light.png');
    await capture(tester, Brightness.dark, 'seasonal_demand_dark.png');
    expect(
        File('screenshots/seasonal_demand_light.png').existsSync(), isTrue);
    expect(File('screenshots/seasonal_demand_dark.png').existsSync(), isTrue);
  });
}
