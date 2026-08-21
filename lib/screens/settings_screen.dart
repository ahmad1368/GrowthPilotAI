import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import '../widgets/adaptive_text.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/omni_glass_panel.dart';
import '../features/settings/widgets/settings_nav_tile.dart';
import '../features/settings/widgets/language_settings_section.dart';
import '../features/settings/widgets/performance_settings_section.dart';
import '../features/settings/widgets/notification_preference_section.dart';
import '../features/settings/widgets/quiet_hours_section.dart';
import '../features/settings/widgets/founding_member_section.dart';
import '../controllers/support_chat_controller.dart';

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

              // Language settings (Issue #429)
              _buildSectionHeader("Language"),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const LanguageSettingsSection(),
              ),

              const SizedBox(height: 32),

              // Power Saver Mode / hardware tier throttling (Issue #110)
              _buildSectionHeader("Performance"),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const PerformanceSettingsSection(),
              ),

              const SizedBox(height: 32),

              // Unified Notification Preference Center (Issue #158)
              _buildSectionHeader("Notifications"),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const NotificationPreferenceSection(),
              ),

              const SizedBox(height: 32),

              // Quiet Hours & daily alert frequency cap (Issue #159)
              _buildSectionHeader("Quiet Hours"),
              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const QuietHoursSection(),
              ),

              const SizedBox(height: 32),

              // Business Academy video hub (Issue #163)
              _buildSectionHeader("Learning"),
              const SizedBox(height: 12),

              SettingsNavTile(
                icon: Icons.play_circle_outline_rounded,
                title: 'Business Academy',
                subtitle: 'Tutorials, marketplace guides, and legal videos',
                onTap: () => Get.toNamed('/academy'),
              ),

              const SizedBox(height: 12),

              SettingsNavTile(
                icon: Icons.psychology_outlined,
                title: 'AI Engine',
                subtitle: 'On-device AI model — download, pause, resume',
                onTap: () => Get.toNamed('/ai-engine'),
              ),

              const SizedBox(height: 32),

              // Branding config for exported PDFs (Issue #257)
              _buildSectionHeader("Branding"),
              const SizedBox(height: 12),

              SettingsNavTile(
                icon: Icons.palette_outlined,
                title: 'Branding',
                subtitle: 'Logo, company name, and brand color for PDF exports',
                onTap: () => Get.toNamed('/settings/branding'),
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

              SettingsNavTile(
                icon: Icons.account_balance_wallet_rounded,
                title: 'Connected Accounts',
                subtitle: 'Manage linked bank sub-accounts',
                onTap: () => Get.toNamed('/settings/connected-accounts'),
              ),

              const SizedBox(height: 12),

              SettingsNavTile(
                icon: Icons.compare_arrows_rounded,
                title: 'Duplicate Matches',
                subtitle: 'Review auto-merged Plaid/accounting transactions',
                onTap: () => Get.toNamed('/transactions/duplicates'),
              ),

              const SizedBox(height: 32),

              // Founding Member Beta Program (Issue #191)
              _buildSectionHeader("Founding Member Beta"),
              const SizedBox(height: 12),

              const FoundingMemberSection(businessId: 'local-user'),

              const SizedBox(height: 32),

              // Subscription management (Issue #171)
              _buildSectionHeader("Billing"),
              const SizedBox(height: 12),

              SettingsNavTile(
                icon: Icons.credit_card_rounded,
                title: 'Manage Billing',
                subtitle: 'Plan, renewal, and cancellation',
                onTap: () => Get.toNamed('/settings/billing'),
              ),

              const SizedBox(height: 32),

              // In-app support chat (Issue #193)
              _buildSectionHeader("Support"),
              const SizedBox(height: 12),

              Obx(() {
                final unread = Get.find<SupportChatController>().unreadCount.value;
                return SettingsNavTile(
                  icon: Icons.support_agent_rounded,
                  title: 'Chat with Support',
                  subtitle: unread > 0 ? '$unread new reply' : 'Ask a question, we\'ll follow up',
                  onTap: () => Get.toNamed('/settings/support'),
                );
              }),

              const SizedBox(height: 32),

              // Local revenue/retention analytics dashboard (Issue #194)
              _buildSectionHeader("Analytics"),
              const SizedBox(height: 12),

              SettingsNavTile(
                icon: Icons.insights_rounded,
                title: 'Analytics Dashboard',
                subtitle: 'Conversion funnel and feature popularity',
                onTap: () => Get.toNamed('/settings/analytics'),
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
