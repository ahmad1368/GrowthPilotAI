import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // اضافه شده برای ناوبری راحت
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import '../pages/settings_page.dart'; // اضافه کردن فایل تنظیمات

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
                        title: "Dashboard",
                        onTap: () => Navigator.pop(context),
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.analytics_rounded,
                        title: "Growth Metrics",
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed('/forecast');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.rule_rounded,
                        title: "Category Mapping",
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed('/category-mapping');
                        },
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.cloud_done_rounded,
                        title: "Azure Status",
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        context,
                        icon: Icons.security_rounded,
                        title: "Security Center",
                        onTap: () {},
                      ),
                      // --- بخش هوشمند: فقط در حالت Debug نمایش داده شود ---
                      if (kDebugMode) ...[
                        Divider(color: onSurface.withValues(alpha: 0.1)),
                        _buildDrawerItem(
                          context,
                          icon: Icons.settings_input_component_rounded,
                          title: "Connection Settings",
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
                        title: "Logout",
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
                    "GrowthPilot AI v1.0.8",
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
}
