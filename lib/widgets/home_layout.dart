import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/transaction_controller.dart';
import '../pages/main_wrapper.dart'; // حتما این را اضافه کنید
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
  @override
  void initState() {
    super.initState();
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
    Get.put(TransactionController());

    // پیدا کردن کنترلر ناوبری که در مراحل قبل ساختیم
    // اگر MainWrapper را هنوز در خروجی اصلی قرار ندادید، اینجا این خط را بگذارید:
    final navControl = Get.put(NavigationController());

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
      // محتوا را بر اساس انتخاب منو نمایش می‌دهیم
      body: Obx(() {
        if (navControl.currentIndex.value == 0) {
          return HomeBody(controller: scrollController);
        } else {
          // اگر ایندکس تغییر کرد، اجازه دهید MainWrapper صفحات را مدیریت کند
          // یا فعلاً برای تست همان HomeBody را برگردانید
          return HomeBody(controller: scrollController);
        }
      }),

      // اصلاح بخش خطا: حذف onTap و استفاده از Obx
      bottomNavigationBar: Obx(() => HomeBottomNav(
            currentIndex: navControl.currentIndex.value,
            // دیگر پارامتر onTap نمی‌دهیم چون داخل خودِ HomeBottomNav تعریف شده است
          )),
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
