import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'adaptive_text.dart';
import 'omni_glass_panel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // مدیریت عرض دراور بر اساس نوع نمایشگر
      width: UIHelper.isWide(context)
          ? 320
          : MediaQuery.of(context).size.width * 0.8,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: OmniGlassPanel(
                opacity: 0.12,
                isInteractive: true,
                height: constraints.maxHeight,
                child: Column(
                  children: [
                    _buildHeader(context),
                    const Divider(color: Colors.white10, height: 30),

                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          _buildDrawerItem(
                            icon: Icons.dashboard_rounded,
                            title: "Dashboard",
                            onTap: () => Navigator.pop(context),
                          ),
                          _buildDrawerItem(
                            icon: Icons.analytics_rounded,
                            title: "Growth Metrics",
                            onTap: () {},
                          ),
                          _buildDrawerItem(
                            icon: Icons.cloud_done_rounded,
                            title: "Azure Status",
                            onTap: () {},
                          ),
                          _buildDrawerItem(
                            icon: Icons
                                .security_rounded, // آیتم جدید برای ملموس بودن امنیت
                            title: "Security Center",
                            onTap: () {},
                          ),
                          const SizedBox(height: 20),
                          _buildDrawerItem(
                            icon: Icons.logout_rounded,
                            title: "Logout",
                            color: Colors.redAccent,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    // فوتر دراور برای نسخه اپلیکیشن
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: AdaptiveText(
                        "GrowthPilot AI v1.0.8",
                        fontSize: 10,
                        style: const TextStyle(color: Colors.white24),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 15),
        const AdaptiveText("Ahmad", fontSize: 18, fontWeight: FontWeight.bold),
        AdaptiveText(
          "Developer", // بر اساس اصلاحیه لجر شما تغییر یافت
          fontSize: 12,
          style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
        ),
      ],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blueAccent, size: 22),
      title: AdaptiveText(
        title,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        style: TextStyle(color: color ?? Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}
