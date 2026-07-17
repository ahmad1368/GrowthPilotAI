import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/theme/mapping_shad_theme.dart';
import 'package:growth_pilot_ai/features/transactions/widgets/merged_provider_badge.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the "Merged" badge (Issue #69) for QA. Not a
/// golden comparison — it only records the current look.
void main() {
  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(220, 60));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: MappingShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: Center(
            child: RepaintBoundary(
              key: key,
              child: Container(
                color: bg,
                padding: const EdgeInsets.all(8),
                child: const MergedProviderBadge(
                    originSources: ['plaid:p1', 'quickbooks:q1']),
              ),
            ),
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

  testWidgets('writes light and dark merged-badge screenshots', (tester) async {
    await capture(tester, Brightness.light, 'merged_provider_badge_light.png');
    await capture(tester, Brightness.dark, 'merged_provider_badge_dark.png');
    expect(File('screenshots/merged_provider_badge_light.png').existsSync(), isTrue);
    expect(File('screenshots/merged_provider_badge_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
