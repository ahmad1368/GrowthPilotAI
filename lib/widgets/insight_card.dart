import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/pages/settings_page.dart';
import 'package:growth_pilot_ai/utils/image_workflow_helper.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';

// وارد کردن ویجت‌ها و سرویس‌های داخلی
import '../widgets/omni_glass_panel.dart';
import '../widgets/adaptive_text.dart';
import '../services/connectivity_service.dart';
import '../services/environment_service.dart';

class InsightPage extends StatelessWidget {
  final ScrollController? controller;

  const InsightPage({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final connectivityService = Get.find<ConnectivityService>();
    final envService = Get.find<EnvironmentService>();

    // افزودن دکمه شناور اسکن با قابلیت ریسپانسیو
    final bool isWide = UIHelper.isWide(context);

    return Listener(
      // محو کردن آیکون سینک با اولین تعامل کاربر (لمس صفحه)
      onPointerDown: (_) => connectivityService.onUserInteraction(),
      child: Obx(() {
        final bool isOnline = connectivityService.isOnline.value;

        // نمایش لایه آفلاین مخصوص وب (فقط برای پلتفرم Web)
        if (kIsWeb && !isOnline) {
          return _buildWebOfflineOverlay();
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context, connectivityService, envService),
          body: CustomScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            slivers: [
              // هدر صفحه
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AdaptiveText(
                        "Smart Analysis",
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      AdaptiveText(
                        "Real-time financial insights based on your spending.",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.6),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // لیست کارت‌های تحلیل (Insights)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => const InsightCard(
                      title: "Expense Optimization",
                      description:
                          "We've detected recurring subscriptions that you haven't used in 3 months. Saving potential: \$45/mo.",
                      efficiency: "High Priority",
                      icon: Icons.trending_down_rounded,
                    ),
                    childCount: 8,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => ImageWorkflowHelper.showPicker(context, (file) {}),
            backgroundColor: Colors.cyanAccent,
            icon:
                const Icon(Icons.document_scanner_rounded, color: Colors.black),
            label: isWide
                ? const AdaptiveText("Scan New Receipt",
                    style: TextStyle(color: Colors.black))
                : const SizedBox.shrink(), // در موبایل فقط آیکون
          ),
        );
      }),
    );
  }

  /// ساخت AppBar با دکمه‌های کنترلی و وضعیت
  PreferredSizeWidget _buildAppBar(
      BuildContext context, ConnectivityService conn, EnvironmentService env) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        // نشانگر وضعیت دیتابیس (فقط در حالت Debug نمایش داده می‌شود)
        if (kDebugMode)
          Obx(() => Tooltip(
                message:
                    env.isRemoteEnabled.value ? "Cloud Mode" : "Local Mode",
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.circle,
                    size: 10,
                    color: env.isRemoteEnabled.value
                        ? Colors.greenAccent
                        : Colors.orangeAccent,
                  ),
                ),
              )),

        // آیکون انیمیشنی Sync (نمایش پس از آنلاین شدن مجدد)
        Obx(() {
          if (!conn.showSyncIcon.value) return const SizedBox.shrink();
          return Icon(
            Icons.sync_rounded,
            color: Theme.of(context).colorScheme.primary,
          ).animate(onPlay: (c) => c.repeat()).rotate(duration: 1500.ms);
        }),

        // دکمه تنظیمات (باز کردن SettingsPage به صورت BottomSheet)
        IconButton(
          icon: const Icon(Icons.settings_outlined, size: 22),
          onPressed: () => Get.bottomSheet(
            const SettingsPage(),
            isScrollControlled: true,
            backgroundColor: Colors.black.withValues(alpha: 0.6),
            barrierColor: Colors.black.withValues(alpha: 0.4),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  /// لایه مسدودکننده برای حالت آفلاین در وب
  Widget _buildWebOfflineOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: Center(
        child: OmniGlassPanel(
          width: 320,
          opacity: 0.2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off_rounded,
                  size: 50, color: Colors.white54),
              const SizedBox(height: 20),
              const AdaptiveText(
                "Offline Mode",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 12),
              AdaptiveText(
                "Please check your internet connection to sync your financial data.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ویجت کارت‌های تحلیل (InsightCard)
class InsightCard extends StatelessWidget {
  final String title;
  final String description;
  final String efficiency;
  final IconData icon;

  const InsightCard({
    super.key,
    required this.title,
    required this.description,
    required this.efficiency,
    this.icon = Icons.auto_awesome_rounded,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Center(
        child: OmniGlassPanel(
          width: UIHelper.getAdaptiveWidth(context),
          opacity: 0.1,
          isInteractive: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AdaptiveText(
                      title,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(icon, color: Colors.amberAccent, size: 22),
                ],
              ),
              const SizedBox(height: 12),
              AdaptiveText(
                description,
                fontSize: 14,
                maxLines: 3,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.offline_bolt_rounded,
                        color: Colors.cyanAccent, size: 16),
                    const SizedBox(width: 8),
                    AdaptiveText(
                      efficiency,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      style: const TextStyle(color: Colors.cyanAccent),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
