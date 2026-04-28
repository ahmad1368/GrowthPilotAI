import 'package:flutter/material.dart';
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

    // به جای ()initLogic خالی، این عبارت را بنویسید:
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
              onPressed: () => Navigator.pushNamed(context, '/settings')),
        ],
      ),
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
                // آپدیت کردن وضعیت خوانده شده در هر دو سطح
                setState(() => item.isRead = true);
                setSheetState(() {});
              },
              onDelete: (item) {
                // ۱. آپدیت لیست اصلی در HomeLogic و بازسازی Layout اصلی
                setState(() {
                  deleteNotification(item.id, () {});
                });

                // ۲. بسیار مهم: آپدیت کردن وضعیتِ خودِ منوی باز شده
                setSheetState(() {
                  // این کار باعث می‌شود کارت بلافاصله از شیت غیب شود
                });
              },
            );
          },
        );
      },
    );
  }
}
