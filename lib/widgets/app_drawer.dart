import 'package:flutter/material.dart';
import 'adaptive_text.dart';
import 'omni_glass_panel.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SafeArea(
        // استفاده از ConstrainedBox برای دادن سقف ارتفاع به پنل شیشه‌ای
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: OmniGlassPanel(
                opacity: 0.12,
                // دادن ارتفاع صریح بر اساس فضای موجود برای حل قطعی خطای Unbounded
                height: constraints.maxHeight,
                child: Column(
                  children: [
                    _buildHeader(context),
                    const Divider(color: Colors.white10, height: 30),

                    // استفاده از Expanded اینجا حالا ایمن است چون OmniGlassPanel ارتفاع دارد
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // متدهای _buildHeader و _buildDrawerItem همان نسخه‌های قبلی باشند
  Widget _buildHeader(BuildContext context) {
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
          "Senior Developer",
          fontSize: 12,
          style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6)),
        ),
      ],
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blueAccent),
      title: AdaptiveText(title, fontSize: 15, fontWeight: FontWeight.w500),
      onTap: onTap,
    );
  }
}
