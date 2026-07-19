import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/models/action_card_data.dart';
import 'package:growth_pilot_ai/core/models/conversation_summary.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/action_card_actions.dart';
import 'package:growth_pilot_ai/features/inbox/widgets/conversation_tile.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void _noop() {}

/// Captures light/dark PNGs of the Inbox conversation list (Issue #72),
/// including a PENDING ACTION_CARD row (Issue #73) and a PENDING
/// anomaly-review row (Issue #74), for QA. Not a golden comparison — it
/// only records the current look.
void main() {
  final summaries = [
    ConversationSummary(
      conversationId: 1,
      subject: 'Home Depot',
      lastMessagePreview: 'Approve the \$450 Home Depot charge to sync it.',
      lastMessageAt: DateTime(2026, 7, 15),
      unreadCount: 2,
      linkedTransactionAmount: 450.0,
      actionCard: const ActionCardData(
        messageId: 9,
        actionType: ActionCardType.approveTransaction,
        status: ActionCardStatus.pending,
        amount: 450.0,
        transactionRefId: 'plaid-hd-451',
      ),
    ),
    ConversationSummary(
      conversationId: 2,
      subject: 'BC Hydro',
      lastMessagePreview: 'Thanks for the update!',
      lastMessageAt: DateTime(2026, 7, 14),
      unreadCount: 0,
    ),
    ConversationSummary(
      conversationId: 3,
      subject: 'Zenith Office Supplies',
      lastMessagePreview: 'Unusual \$2400.00 charge — please review.',
      lastMessageAt: DateTime(2026, 7, 16),
      unreadCount: 1,
      linkedTransactionAmount: 2400.0,
      actionCard: const ActionCardData(
        messageId: 11,
        actionType: ActionCardType.reviewAnomaly,
        status: ActionCardStatus.pending,
        amount: 2400.0,
        transactionRefId: 'plaid-zenith-9012',
        merchantName: 'Zenith Office Supplies',
        anomalyType: AnomalyType.zScore,
      ),
    ),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(400, 320));
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
                children: summaries
                    .map((s) => ConversationTile(
                          summary: s,
                          onTap: () {},
                          actions: const ActionCardActions(
                            isApproving: false,
                            onApprove: _noop,
                            isIgnoringAnomaly: false,
                            onIgnoreAnomaly: _noop,
                          ),
                        ))
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
