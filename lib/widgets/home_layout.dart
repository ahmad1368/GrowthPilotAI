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
    // ۱. تزریق کنترلر تراکنش‌ها برای دسترسی در تمام بخش‌های لایه اصلی
    final TransactionController transactionController =
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
      // استفاده از Stack برای اینکه ویجت تست روی HomeBody قرار بگیرد یا ترکیب شود
      body: Stack(
        children: [
          // محتوای اصلی اپلیکیشن
          HomeBody(controller: scrollController),

          // ۲. ویجت تست لایه AI و دیتابیس (نمایش به صورت شناور برای تست)
          Positioned(
            top: 120, // زیر AppBar قرار بگیرد
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.analytics_outlined),
                    onPressed: () => transactionController.loadLastMonthData(),
                    label: const Text("Filter Last Month (AI Test)"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.withOpacity(0.8),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // استفاده از Obx برای به‌روزرسانی آنی تعداد تراکنش‌ها
                  // داخل متد build و در بخشی که دکمه را گذاشتی:
                  Obx(() {
                    // این پرینت به تو می‌گوید که آیا Obx اصلاً دوباره اجرا می‌شود یا نه
                    print(
                        "UI در حال بازسازی با تعداد: ${transactionController.filteredTransactions.length}");

                    return Text(
                      "Found: Ahmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmad ${transactionController.filteredTransactions.length} Transactions",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
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
