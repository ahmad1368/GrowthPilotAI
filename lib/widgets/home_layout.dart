import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/intelligence_status_controller.dart';
import '../controllers/transaction_controller.dart';
import '../core/theme/app_background_pattern.dart';
import '../pages/main_wrapper.dart'; // حتما این را اضافه کنید
import 'app_drawer.dart';
import 'app_shell_bar.dart';
import 'home_body.dart';
import 'home_bottom_nav.dart';
import 'intelligence_status_badge.dart';
import 'notification_badge.dart';
import 'home_logic.dart';
import 'notification_sheet.dart';
import '../pages/insight_page.dart';
import '../pages/profile_placeholder_page.dart';

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
    Get.put(IntelligenceStatusController());

    // پیدا کردن کنترلر ناوبری که در مراحل قبل ساختیم
    // اگر MainWrapper را هنوز در خروجی اصلی قرار ندادید، اینجا این خط را بگذارید:
    final navControl = Get.put(NavigationController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: const AppDrawer(),
      appBar: AppShellBar(
        titleIcon: Icons.trending_up_rounded,
        opacity: appBarOpacity,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: IntelligenceStatusBadge(),
          ),
          NotificationBadge(count: unreadCount, onTap: _openNotifications),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            // [Issue #794] A raw Navigator.pushNamed here didn't reliably
            // resolve through GetMaterialApp's page/middleware pipeline
            // (ModuleAccessMiddleware on the '/settings' GetPage), silently
            // no-op'ing. Get.toNamed matches how every other route in this
            // app is pushed.
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
      // محتوا را بر اساس انتخاب منو نمایش می‌دهیم
      // [Issue #784] پس‌زمینه‌ی برند شده پشت محتوای اصلی برنامه
      body: AppBackgroundPattern(
        child: Obx(() {
          switch (navControl.currentIndex.value) {
            // [Issue #798] Was unconditionally HomeBody for every index —
            // the "Insights" bottom-nav tab did nothing. Note: HomeBody
            // itself already just renders InsightPage (see home_body.dart),
            // so this wires the tab to the same real Insights screen the
            // Home tab already shows, rather than adding a second
            // half-built one.
            // [Issue #815] That left Home and Insights visually identical
            // (neither passed a title/icon to InsightPage), so switching
            // tabs looked like nothing happened — this gives Insights its
            // own header so the two are visibly distinct.
            case 1:
              return InsightPage(
                controller: scrollController,
                title: 'nav_insights'.tr,
                icon: Icons.bar_chart_rounded,
              );
            // [Issue #815] Profile had no case of its own and silently fell
            // through to the same HomeBody/InsightPage content as Home —
            // an honest "coming soon" placeholder instead, since no real
            // profile feature exists yet.
            case 3:
              return const ProfilePlaceholderPage();
            default:
              return HomeBody(controller: scrollController);
          }
        }),
      ),

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
