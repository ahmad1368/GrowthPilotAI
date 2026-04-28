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
      barrierColor: Colors.black54, // برای اینکه با کلیک بیرون بسته شود (بند ۴)
      builder: (context) {
        // استفاده از StatefulBuilder برای اینکه تغییرات (مثل خوانده شدن)
        // بلافاصله درون شیت دیده شود
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return NotificationSheet(
              notifications:
                  notifications, // لیست نوتیفیکیشن‌ها که در HomeLogic دارید
              // در فایل home_layout.dart
              onRead: (item) {
                setState(() {
                  item.isRead =
                      true; // این تغییر در لیست موجود در HomeLogic اعمال می‌شود
                });
                setSheetState(() {}); // این برای آپدیت شدن ظاهر خودِ منو است
              },
            );
          },
        );
      },
    );
  }
}
