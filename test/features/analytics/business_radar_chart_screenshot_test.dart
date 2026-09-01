import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_radar_chart.dart';

/// Renders the Issue #84 Business Compass radar offscreen and writes
/// light/dark PNGs into `screenshots/` for the PR. Not a golden comparison
/// — it only captures the current look.
void main() {
  const user = BusinessCompassMetrics(
    liquidityRatio: 0.7,
    burnVelocity: 0.4,
    vendorDiversity: 0.6,
    paymentPunctuality: 0.85,
    profitMargin: 0.5,
  );
  const sector = BusinessCompassMetrics(
    liquidityRatio: 0.8,
    burnVelocity: 0.45,
    vendorDiversity: 0.4,
    paymentPunctuality: 0.9,
    profitMargin: 0.55,
  );

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final key = GlobalKey();
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    await tester.binding.setSurfaceSize(const Size(360, 360));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: RepaintBoundary(
        key: key,
        child: Container(
          color: bg,
          padding: const EdgeInsets.all(12),
          child: const BusinessRadarChart(
              userMetrics: user, sectorMetrics: sector),
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

  testWidgets('writes light and dark business compass radar screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'business_compass_radar_light.png');
    await capture(tester, Brightness.dark, 'business_compass_radar_dark.png');
    expect(File('screenshots/business_compass_radar_light.png').existsSync(),
        isTrue);
    expect(File('screenshots/business_compass_radar_dark.png').existsSync(),
        isTrue);
  });
}
