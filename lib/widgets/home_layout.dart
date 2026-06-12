import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/presentation/widgets/app_drawer.dart';
import 'package:growth_pilot_ai/features/navigation/controllers/navigation_controller.dart';
import '../controllers/transaction_controller.dart';
import 'home_body.dart';
import 'home_bottom_nav.dart';
import 'home_logic.dart';
import 'home_layout_app_bar.dart';

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
    final navControl = Get.put(NavigationController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ... کدهای قبلی متد بیلد

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      drawer: const AppDrawer(),
      appBar: HomeLayoutAppBar(
        unreadCount: unreadCount,
        notifications: notifications,
        onRefresh: () => setState(() {}),
        deleteNotification: deleteNotification,
      ),

      // اصلاح بخش خطا: متغیر واکنش‌گرای currentIndex مستقیماً درون دامنه Obx ارزیابی می‌شود
      body: Obx(() {
        if (navControl.currentIndex.value == 0) {
          return HomeBody(controller: scrollController);
        }
        // برای ایندکس‌های ۱ و ۲ (تحلیل‌ها و اسکنر) می‌توان صفحات دیگر یا موقتاً همان هوم‌بادی را رندر کرد
        return HomeBody(controller: scrollController);
      }),

      bottomNavigationBar:
          Obx(() => HomeBottomNav(currentIndex: navControl.currentIndex.value)),
    );
  }
}
