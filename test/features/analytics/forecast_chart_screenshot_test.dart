import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/forecast_chart.dart';

/// Renders the flat forecast chart offscreen and writes light/dark PNGs into
/// `screenshots/` for the PR. Not a golden comparison — it only captures the
/// current look, so it never fails on cross-platform pixel drift.
void main() {
  const history = [40.0, 52.0, 48.0, 61.0, 55.0, 70.0, 66.0, 80.0, 110.0];
  const forecast = [118.0, 126.0, 134.0];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final key = GlobalKey();
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    await tester.binding.setSurfaceSize(const Size(640, 380));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: RepaintBoundary(
        key: key,
        child: Container(
          color: bg,
          padding: const EdgeInsets.fromLTRB(12, 24, 24, 24),
          child: const ForecastChart(historical: history, forecast: forecast),
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

  testWidgets('writes light and dark forecast screenshots', (tester) async {
    await capture(tester, Brightness.light, 'forecast_light.png');
    await capture(tester, Brightness.dark, 'forecast_dark.png');
    expect(File('screenshots/forecast_light.png').existsSync(), isTrue);
    expect(File('screenshots/forecast_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
