import 'package:flutter/material.dart';
import '../models/notification_model.dart';

mixin HomeLogic {
  // ۱. تعریف اسکرول کنترلر
  final ScrollController scrollController = ScrollController();

  // ۲. تعریف متغیر برای شفافیت اپ‌بار
  double appBarOpacity = 0.0;

  // لیست نوتیفیکیشن‌ها (که قبلاً اضافه کردیم)
  List<AppNotification> notifications = List.generate(
      12,
      (index) => AppNotification(
            id: index.toString(),
            title: 'اعلان سیستم ${index + 1}',
            body: 'گزارش تحلیلی شماره ${index + 1} آماده بررسی است.',
            footer: 'System • AI Engine',
            date: DateTime.now().subtract(Duration(hours: index)),
            isRead: false,
          ));

  int get unreadCount => notifications.where((n) => !n.isRead).length;

  // ۳. متد مقداردهی اولیه برای گوش دادن به اسکرول
  void initLogic(VoidCallback onUpdate) {
    scrollController.addListener(() {
      // محاسبه شفافیت بین 0.0 تا 1.0 بر اساس 150 پیکسل اسکرول
      double newOpacity = (scrollController.offset / 150).clamp(0.0, 1.0);

      if (newOpacity != appBarOpacity) {
        appBarOpacity = newOpacity;
        onUpdate(); // فراخوانی setState در فایل Layout
      }
    });
  }

  void disposeLogic() {
    scrollController.dispose();
  }
}
