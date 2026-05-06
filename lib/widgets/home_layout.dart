import 'package:flutter/material.dart';
import 'package:get/get.dart'; // اضافه شده برای مدیریت وضعیت GetX
import '../controllers/transaction_controller.dart'; // کنترلر تراکنش‌ها
import 'app_drawer.dart';
import 'glass_app_bar.dart';
import 'home_body.dart';
import 'home_bottom_nav.dart';
import 'notification_badge.dart';
import 'home_logic.dart';
import 'notification_sheet.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with HomeLogic {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // راه‌اندازی منطق نوتیفیکیشن‌ها و اسکرول
    initLogic(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    disposeLogic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // تزریق کنترلر تراکنش‌ها برای دسترسی در تمام بخش‌های لایه اصلی
    // نکته: Get.put تضمین می‌کند که کنترلر در حافظه لود شده است
    Get.put(TransactionController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: const AppDrawer(),
      appBar: GlassAppBar(
        title: "GrowthPilot AI",
        opacity: appBarOpacity,
        actions: [
          NotificationBadge(count: unreadCount, onTap: _openNotifications),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      // حذف Stack و Positioned اضافی که باعث خطا می‌شد
      // حالا مستقیماً محتوای اصلی نمایش داده می‌شود
      body: HomeBody(controller: scrollController),

      bottomNavigationBar: HomeBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }

  void _openNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return NotificationSheet(
              notifications: notifications,
              onRead: (item) {
                setState(() => item.isRead = true);
                setSheetState(() {});
              },
              onDelete: (item) {
                setState(() {
                  deleteNotification(item.id, () {});
                });
                setSheetState(() {});
              },
            );
          },
        );
      },
    );
  }
}
