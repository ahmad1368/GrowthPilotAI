import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import '../widgets/adaptive_text.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/omni_glass_panel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AdaptiveTheme.of(context).mode.isDark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const AdaptiveText(
          "Settings",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // ۱. تیتر بخش ظاهر
          _buildSectionHeader("Appearance"),
          const SizedBox(height: 12),

          // ۲. پیاده‌سازی Issue #8 با استفاده از سیستم جدید ویجت‌ها
          OmniGlassPanel(
            opacity: 0.1, // غلظت کمی بیشتر برای جدا شدن کارت‌ها از پس‌زمینه
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                color: isDark ? Colors.cyanAccent : Colors.orangeAccent,
                size: 28,
              ),
              title:
                  const AdaptiveText("App Theme", fontWeight: FontWeight.bold),
              subtitle: AdaptiveText(
                "Switch between Day and Night",
                fontSize: 12,
                style: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
              ),
              trailing: const ThemeToggle(),
            ),
          ),

          const SizedBox(height: 32),

          // ۳. بخش‌های دیگر (مثال برای تست سیستم جدید)
          _buildSectionHeader("Account"),
          const SizedBox(height: 12),

          OmniGlassPanel(
            opacity: 0.1,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.person_outline_rounded,
                  color: theme.colorScheme.onSurface),
              title: const AdaptiveText("Profile Settings"),
              trailing: Icon(Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
            ),
          ),

          const SizedBox(height: 40),
          const Center(
            child: AdaptiveText(
              "GrowthPilot AI v1.0.8",
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  // ویجت کمکی برای تیتر بخش‌ها
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: AdaptiveText(
        title.toUpperCase(),
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
