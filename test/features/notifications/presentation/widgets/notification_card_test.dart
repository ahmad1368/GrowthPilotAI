import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/notification_card.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart'; // 💡 اضافه کردن امپورت جهت رندر صحیح محیط ShadApp

void main() {
  testWidgets('NotificationCard renders flat shadcn items successfully',
      (WidgetTester tester) async {
    final mockNotification = AppNotification(
      id: "test_id_123", // 💡 رفع خطای مطلوب پارامتر اجباری id
      title: "System Update",
      body: "Database backup completed.",
      footer: "System Automation", // 💡 رفع خطای مطلوب پارامتر اجباری footer
      date: DateTime(2026, 6, 12), // 💡 رفع خطای مطلوب پارامتر اجباری date
      type: NotificationType.alert,
      isRead: false,
    );

    // 💡 جایگزینی MaterialApp با ShadApp جهت تامین سیستم توزیع تم پکیج مسطح
    await tester.pumpWidget(ShadApp(
      home: Scaffold(
        body: NotificationCard(
          item: mockNotification,
          onTap: () {},
          onDelete: () {},
        ),
      ),
    ));

    expect(find.text("System Update"), findsOneWidget);
  });
}
