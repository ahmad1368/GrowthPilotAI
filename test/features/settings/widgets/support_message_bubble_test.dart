import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/support_message_entity.dart';
import 'package:growth_pilot_ai/core/enum/support_message_sender.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/support_message_bubble.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// SupportMessageBubble reads ShadTheme.of(context) directly, so it needs a
// ShadTheme ancestor when pumped in isolation (in the real app this comes
// from SupportChatScreen's self-wrap / the app-wide builder in main.dart).
Widget _wrap(Widget child) => GetMaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  group('SupportMessageBubble', () {
    testWidgets('renders the message body for a user message', (tester) async {
      final message = SupportMessageEntity(
        businessId: 'local-user',
        dbSender: SupportMessageSender.user.index,
        body: 'My bank connection failed',
        sentAt: DateTime(2026, 1, 1, 10, 30),
      );

      await tester.pumpWidget(_wrap(SupportMessageBubble(message: message)));

      expect(find.text('My bank connection failed'), findsOneWidget);
    });

    testWidgets('renders the message body for an agent reply', (tester) async {
      final message = SupportMessageEntity(
        businessId: 'local-user',
        dbSender: SupportMessageSender.agent.index,
        body: 'A team member will follow up shortly.',
        sentAt: DateTime(2026, 1, 1, 10, 31),
      );

      await tester.pumpWidget(_wrap(SupportMessageBubble(message: message)));

      expect(find.text('A team member will follow up shortly.'), findsOneWidget);
    });
  });
}
