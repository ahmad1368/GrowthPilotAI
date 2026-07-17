import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/core/theme/inbox_shad_theme.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/conversation_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the Inbox conversation list (Issue #72) for
/// QA. Not a golden comparison — it only records the current look.
void main() {
  final summaries = [
    ConversationSummary(
      conversationId: 1,
      subject: 'Home Depot',
      lastMessagePreview: 'Can you confirm the delivery window?',
      lastMessageAt: DateTime(2026, 7, 15),
      unreadCount: 2,
      linkedTransactionAmount: 128.40,
    ),
    ConversationSummary(
      conversationId: 2,
      subject: 'BC Hydro',
      lastMessagePreview: 'Thanks for the update!',
      lastMessageAt: DateTime(2026, 7, 14),
      unreadCount: 0,
    ),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(400, 220));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: InboxShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: bg,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: summaries
                    .map((s) => ConversationTile(summary: s, onTap: () {}))
                    .toList(),
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

  testWidgets('writes light and dark inbox conversation-tile screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'inbox_conversation_tile_light.png');
    await capture(tester, Brightness.dark, 'inbox_conversation_tile_dark.png');
    expect(
        File('screenshots/inbox_conversation_tile_light.png').existsSync(),
        isTrue);
    expect(
        File('screenshots/inbox_conversation_tile_dark.png').existsSync(),
        isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
