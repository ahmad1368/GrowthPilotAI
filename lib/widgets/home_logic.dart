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
            body: 'توضیحات کامل این بخش برای پروژه GrowthPilotAI...',
            footer: 'Version 1.0.8',
            date: DateTime.now(),
            type: NotificationType.values[index % 5], // توزیع انواع مختلف
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
