import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/forecast_summary_card.dart';

/// Captures light/dark PNGs of the flat forecast summary card for the PR.
/// Not a golden comparison — it only records the current look.
void main() {
  const history = [40.0, 52.0, 48.0, 61.0, 55.0, 70.0, 66.0];
  const forecast = [72.0, 74.0, 76.0, 78.0, 80.0, 82.0, 84.0];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final key = GlobalKey();
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    await tester.binding.setSurfaceSize(const Size(560, 260));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: RepaintBoundary(
        key: key,
        child: Material(
          color: bg,
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: ForecastSummaryCard(
                history: history, forecast: forecast),
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

  testWidgets('writes light and dark summary-card screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'forecast_card_light.png');
    await capture(tester, Brightness.dark, 'forecast_card_dark.png');
    expect(File('screenshots/forecast_card_light.png').existsSync(), isTrue);
    expect(File('screenshots/forecast_card_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
