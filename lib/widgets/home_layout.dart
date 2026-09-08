import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../business/queue_intelligence_update_notification.dart';
import '../controllers/intelligence_status_controller.dart';
import '../controllers/transaction_controller.dart';
import '../core/theme/app_background_pattern.dart';
import '../pages/main_wrapper.dart'; // حتما این را اضافه کنید
import 'app_drawer.dart';
import 'app_shell_bar.dart';
import 'home_body.dart';
import 'home_bottom_nav.dart';
import 'notification_badge.dart';
import 'home_logic.dart';
import 'notification_sheet.dart';
import '../pages/insight_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with HomeLogic {
  late final IntelligenceStatusController _intelligenceController;
  late final NavigationController _navControl;

  @override
  void initState() {
    super.initState();
    initLogic(() {
      if (mounted) setState(() {});
    });

    // [Issue #833] Was re-registered on every build() — every scroll-driven
    // appBarOpacity rebuild via HomeLogic re-put these, which is wasteful
    // and would have fired the sync-once call below repeatedly.
    Get.put(TransactionController());
    _intelligenceController = Get.put(IntelligenceStatusController());
    _navControl = Get.put(NavigationController());

    _maybeSyncIntelligence();
  }

  // [Issue #833] Nothing ever called IntelligenceStatusController.sync(),
  // so its state stayed permanently hardcoded to "Update required" (its
  // initial value) forever. An empty bundles map is enough to let
  // syncIfDue record a real lastSyncedAt and resolve a real state instead
  // of the hardcoded default — populating actual per-sector bundles is
  // separate, larger follow-up work (see the issue). If still required
  // after syncing, surface it as a notification, not a permanent banner.
  Future<void> _maybeSyncIntelligence() async {
    await _intelligenceController.sync(const {});
    if (!mounted) return;
    if (QueueIntelligenceUpdateNotification.call(_intelligenceController.state.value, notifications)) {
      setState(() {});
    }
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
      appBar: AppShellBar(
        titleIcon: Icons.trending_up_rounded,
        opacity: appBarOpacity,
        actions: [
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
          switch (_navControl.currentIndex.value) {
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
            // [Issue #831] Profile's old case 3 (a "coming soon"
            // placeholder, #815) is gone — Profile is a real drawer-only
            // screen now (#826), and index 3 is intercepted by
            // NavigationController.handleNavigation for Marketplace
            // before currentIndex ever reaches this switch.
            default:
              return HomeBody(controller: scrollController);
          }
        }),
      ),

      // اصلاح بخش خطا: حذف onTap و استفاده از Obx
      bottomNavigationBar: Obx(() => HomeBottomNav(
            currentIndex: _navControl.currentIndex.value,
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
