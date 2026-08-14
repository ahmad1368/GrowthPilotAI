import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_report_widget.dart';

TransactionEntity _txAt(DateTime date) =>
    TransactionEntity(amount: 10, date: date, description: 'x');

/// Captures light/dark PNGs of the new Peak Hours Customer Traffic widget
/// (Issue #365) for QA. Not a golden comparison — it only records the look.
void main() {
  final transactions = [
    for (var i = 0; i < 8; i++) _txAt(DateTime(2026, 3, 5, 14, i)),
    _txAt(DateTime(2026, 3, 6, 9, 0)),
    _txAt(DateTime(2026, 3, 7, 18, 0)),
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
            child: TrafficReportWidget(
                data: {'transactions': transactions}, title: 'Peak Hours Traffic'),
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

  testWidgets('writes light and dark traffic-widget screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'traffic_analysis_light.png');
    await capture(tester, Brightness.dark, 'traffic_analysis_dark.png');
    expect(File('screenshots/traffic_analysis_light.png').existsSync(), isTrue);
    expect(File('screenshots/traffic_analysis_dark.png').existsSync(), isTrue);
  });
}
