import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/action_card_actions.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/dismissible_conversation_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void _noop() {}
const _actions = ActionCardActions(
  isApproving: false,
  onApprove: _noop,
  isIgnoringAnomaly: false,
  onIgnoreAnomaly: _noop,
  isProcessingRecommendation: false,
  onActRecommendation: _noop,
  onDismissRecommendation: _noop,
  onSnoozeRecommendation: _noop,
);

/// Captures light/dark PNGs of the Issue #76 swipe/multi-select Inbox row:
/// the normal swipeable tile and the selection-mode checkbox tile. Not a
/// golden comparison — it only records the current look.
void main() {
  final summaries = [
    ConversationSummary(
      conversationId: 1,
      subject: 'Home Depot',
      lastMessagePreview: 'Approve the \$450 Home Depot charge to sync it.',
      unreadCount: 2,
      lastMessageAt: DateTime(2026, 7, 15),
    ),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(400, 220));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: bg,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DismissibleConversationTile(
                    summary: summaries.first,
                    actions: _actions,
                    selectionMode: false,
                    isSelected: false,
                    onLongPress: _noop,
                    onToggleSelected: _noop,
                    onArchive: _noop,
                    onOpen: _noop,
                  ),
                  DismissibleConversationTile(
                    summary: summaries.first,
                    actions: _actions,
                    selectionMode: true,
                    isSelected: true,
                    onLongPress: _noop,
                    onToggleSelected: _noop,
                    onArchive: _noop,
                    onOpen: _noop,
                  ),
                ],
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

  testWidgets(
      'writes light and dark swipe/multi-select inbox row screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'inbox_archive_select_light.png');
    await capture(tester, Brightness.dark, 'inbox_archive_select_dark.png');
    expect(File('screenshots/inbox_archive_select_light.png').existsSync(), isTrue);
    expect(File('screenshots/inbox_archive_select_dark.png').existsSync(), isTrue);
  });
}
