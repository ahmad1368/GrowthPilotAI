// lib/models/notification_model.dart

class AppNotification {
  final String id;
  final String title;
  final String body; // محتوای اصلی نوتیفیکیشن
  final String footer; // پاورقی (مثل بخش مربوطه)
  final DateTime date; // استفاده از DateTime برای مدیریت بهتر زمان
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.footer,
    required this.date,
    this.isRead = false,
  });
}

// دیتای پایه ۱۲ تایی هماهنگ با مدل جدید
List<AppNotification> dummyNotifications = List.generate(
  12,
  (index) => AppNotification(
    id: index.toString(),
    title: 'اعلان سیستم ${index + 1}',
    body:
        'این یک پیام آزمایشی برای بررسی وضعیت نوتیفیکیشن در GrowthPilotAI است.',
    footer: 'System • Analytics',
    date: DateTime.now().subtract(Duration(hours: index)),
    isRead: false,
  ),
);
