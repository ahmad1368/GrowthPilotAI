import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // اضافه شده برای ناوبری راحت
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import '../pages/settings_page.dart'; // اضافه کردن فایل تنظیمات
import '../features/settings/screens/security_center_screen.dart';

/// Flat drawer — replaces the former OmniGlassPanel/AdaptiveText wrapper
/// with a card-colored container (matches HomeBottomNav's pattern). Also
/// fixes hardcoded white text/dividers that only looked correct in dark
/// mode; colors now follow [Theme.of(context)] in both modes.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final onSurface = theme.colorScheme.onSurface;

    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // مدیریت عرض دراور بر اساس نوع نمایشگر
      width: UIHelper.isWide(context)
          ? 320
          : MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppDesignTokens.card(brightness),
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
              border: Border.all(color: onSurface.withValues(alpha: 0.08)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                _buildHeader(context),
                Divider(color: onSurface.withValues(alpha: 0.1), height: 30),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      _buildDrawerItem(
                        context,
                        icon: Icons.dashboard_rounded,
                        title: 'drawer_dashboard'.tr,
                        onTap: () => Navigator.pop(context),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.analytics_rounded,
                        title: 'drawer_growth_metrics'.tr,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed('/forecast');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.warehouse_rounded,
                        title: 'drawer_business_compass'.tr,
                        // [Issue #818] BusinessCompassScreen ('/business-compass')
                        // hosts every inventory/accounting report widget built
                        // across #84, #111, #113-116, #355, #435-#447 — none of
                        // it was reachable from any menu, only a deep link.
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed('/business-compass');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.rule_rounded,
                        title: 'drawer_category_mapping'.tr,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed('/category-mapping');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.cloud_done_rounded,
                        title: 'drawer_azure_status'.tr,
                        // [Issue #802] No real Azure integration exists in
                        // this app to report genuine status for — a simple
                        // "Coming Soon" placeholder instead of a fabricated
                        // status indicator, or the previous no-op.
                        onTap: () => _showComingSoon(context, title: 'drawer_azure_status'.tr),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.security_rounded,
                        title: 'drawer_security_center'.tr,
                        // [Issue #804] Wires up the previously-unwired
                        // Issue #186 security-audit-log viewer.
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(() => const SecurityCenterScreen());
                        },
                      ),
                      // --- بخش هوشمند: فقط در حالت Debug نمایش داده شود ---
                      if (kDebugMode) ...[
                        Divider(color: onSurface.withValues(alpha: 0.1)),
                        _buildDrawerItem(
                          context,
                          icon: Icons.settings_input_component_rounded,
                          title: 'drawer_connection_settings'.tr,
                          color: Colors
                              .orangeAccent, // تغییر رنگ برای تمایز در حالت Dev
                          onTap: () {
                            Navigator.pop(context);
                            Get.to(() => const SettingsPage());
                          },
                        ),
                      ],
                      Divider(
                          color: onSurface.withValues(alpha: 0.1), height: 40),
                      _buildDrawerItem(
                        context,
                        icon: Icons.logout_rounded,
                        title: 'drawer_logout'.tr,
                        color: Colors.redAccent,
                        onTap: () {
                          // منطق خروج
                        },
                      ),
                    ],
                  ),
                ),
                // فوتر دراور برای نسخه اپلیکیشن
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "${'app_name'.tr} v1.0.8",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: onSurface.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 15),
        Text("Ahmad",
            style: theme.textTheme.titleMedium
                ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(
          "Senior Developer", // بر اساس تخصص شما آپدیت شد
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12,
            color: onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blueAccent, size: 22),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color ?? theme.colorScheme.onSurface,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }

  /// [Issue #802] Honest placeholder for drawer entries with no real
  /// feature behind them yet. Closes the drawer first, then shows the
  /// dialog via Get.dialog — a plain `showDialog(context: context, ...)`
  /// here used the drawer item's own BuildContext right after popping it,
  /// which is unmounting at that point (the drawer is closing), so the
  /// dialog silently never appeared. Get.dialog uses GetX's own root
  /// overlay instead of that local, about-to-be-unmounted context —
  /// matching how the adjacent "Security Center" item's Get.to() call
  /// (which works) avoids the same trap.
  void _showComingSoon(BuildContext context, {required String title}) {
    Navigator.pop(context);
    Get.dialog(
      ShadDialog.alert(
        title: Text(title),
        description: Text('common_coming_soon'.tr),
        actions: [
          ShadButton(
            onPressed: () => Get.back(),
            child: Text('common_ok'.tr),
          ),
        ],
      ),
    );
  }
}
