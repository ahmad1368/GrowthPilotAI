import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/inbox_category.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/inbox_filter_chips.dart';

/// Captures light/dark PNGs of the Issue #77 Inbox filter bar, with the
/// "Pending" chip showing its badge count. Not a golden comparison — it
/// only records the current look.
void main() {
  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(400, 100));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        backgroundColor: bg,
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child: InboxFilterChips(
              selected: InboxCategory.pending,
              pendingCount: 3,
              onChanged: (_) {},
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

  testWidgets('writes light and dark inbox filter chip screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'inbox_filter_chips_light.png');
    await capture(tester, Brightness.dark, 'inbox_filter_chips_dark.png');
    expect(File('screenshots/inbox_filter_chips_light.png').existsSync(), isTrue);
    expect(File('screenshots/inbox_filter_chips_dark.png').existsSync(), isTrue);
  });
}
