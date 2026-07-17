import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import '../widgets/adaptive_text.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/omni_glass_panel.dart';
import '../features/settings/widgets/connected_accounts_nav_tile.dart';

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
      body: Center(
        // اضافه شدن Center برای مدیریت نمایشگرهای عریض
        child: Container(
          // استفاده از UIHelper برای تعیین عرض هوشمند
          width: UIHelper.getAdaptiveWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              // ۱. بخش ظاهر (Appearance)
              _buildSectionHeader("Appearance"),
              const SizedBox(height: 12),

              OmniGlassPanel(
                opacity: 0.1,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: Icon(
                    isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    color: isDark ? Colors.cyanAccent : Colors.orangeAccent,
                    size: 28,
                  ),
                  title: const AdaptiveText("App Theme",
                      fontWeight: FontWeight.bold),
                  subtitle: AdaptiveText(
                    "Switch between Day and Night",
                    fontSize: 12,
                    style: TextStyle(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                  trailing: const ThemeToggle(),
                ),
              ),

              const SizedBox(height: 32),

              // Accounting & Banking integrations dashboard (Issue #61)
              _buildSectionHeader("Integrations"),
              const SizedBox(height: 12),

              OmniGlassPanel(
                opacity: 0.1,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: Icon(Icons.account_balance_rounded,
                      color: theme.colorScheme.onSurface),
                  title: const AdaptiveText("Accounting & Banking"),
                  subtitle: AdaptiveText(
                    "Plaid, QuickBooks, Xero connections",
                    fontSize: 12,
                    style: TextStyle(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                  trailing: Icon(Icons.chevron_right_rounded,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                  onTap: () => Get.toNamed('/settings/integrations'),
                ),
              ),

              const SizedBox(height: 12),

              ConnectedAccountsNavTile(
                onTap: () => Get.toNamed('/settings/connected-accounts'),
              ),

              const SizedBox(height: 32),

              // ۲. بخش حساب کاربری (Account)
              _buildSectionHeader("Account"),
              const SizedBox(height: 12),

              OmniGlassPanel(
                opacity: 0.1,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: Icon(Icons.person_outline_rounded,
                      color: theme.colorScheme.onSurface),
                  title: const AdaptiveText("Profile Settings"),
                  trailing: Icon(Icons.chevron_right_rounded,
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.3)),
                ),
              ),

              const SizedBox(height: 12),

              // ۳. بخش امنیت (Security) - ملموس کردن قابلیت‌های جدید
              _buildSectionHeader("Security"),
              const SizedBox(height: 12),

              const OmniGlassPanel(
                opacity: 0.1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  leading: Icon(Icons.security_rounded,
                      color: Colors.greenAccent),
                  title: AdaptiveText("Local Encryption"),
                  subtitle: AdaptiveText(
                    "AES-256 Protection Active",
                    fontSize: 11,
                  ),
                  trailing: Icon(
                    Icons.verified_user_rounded,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // نسخه اپلیکیشن با طراحی مینیمال
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.auto_awesome,
                        size: 16, color: Colors.white24),
                    const SizedBox(height: 8),
                    AdaptiveText(
                      "GrowthPilot AI v1.0.8",
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      style: TextStyle(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4)),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: AdaptiveText(
        title.toUpperCase(),
        fontSize: 11,
        fontWeight: FontWeight.w900,
        style: const TextStyle(letterSpacing: 1.2, color: Colors.blueAccent),
      ),
    );
  }
}
