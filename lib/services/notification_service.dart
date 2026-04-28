import '../models/notification_model.dart';

class NotificationService {
  // ۱. متد اصلی برای دریافت نوتیفیکیشن‌ها از منبع (فعلاً Mock، بعداً API)
  Future<List<AppNotification>> fetchNotifications() async {
    // شبیه‌سازی تاخیر شبکه برای واقعی‌تر شدن تجربه کاربری
    await Future.delayed(const Duration(milliseconds: 800));

    try {
      // ایجاد ۱۲ آیتم به صورت داینامیک برای تست (بند ۱ درخواست شما)
      return List.generate(12, (index) {
        return AppNotification(
          id: (index + 1).toString(),
          title: _getMockTitle(index),
          body:
              'گزارش تحلیلی شماره ${index + 1} در سیستم GrowthPilotAI آماده شد. لطفا جزئیات را در پنل مدیریت بررسی کنید.',
          footer: _getMockFooter(index),
          date: DateTime.now().subtract(Duration(hours: index, minutes: 15)),
          isRead: false,
        );
      });
    } catch (e) {
      // در صورت بروز خطا، یک لیست خالی برمی‌گردانیم تا برنامه کرش نکند
      print("Error in NotificationService: $e");
      return [];
    }
  }

  // ۲. متد برای تغییر وضعیت خوانده شدن (بدون بستن منو - بند ۴)
  Future<void> markAsRead(AppNotification notification) async {
    // اینجا در آینده دستور آپدیت به API فرستاده می‌شود:
    // await http.patch('api/notifications/${notification.id}', data: {'isRead': true});

    notification.isRead = true;
    print("Notification ${notification.id} marked as read in Service.");
  }

  // متدهای کمکی برای تولید دیتای متنوع
  String _getMockTitle(int i) {
    const titles = [
      "AI Analysis",
      "System Security",
      "Marketplace",
      "Cloud Sync"
    ];
    return titles[i % titles.length];
  }

  String _getMockFooter(int i) {
    const footers = [
      "Analytics Engine",
      "Security Center",
      "Sales Team",
      "Infrastructure"
    ];
    return footers[i % footers.length];
  }
}
