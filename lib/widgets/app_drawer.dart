import 'package:flutter/material.dart';
import 'adaptive_text.dart';
import 'omni_glass_container.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      // استفاده از رنگ شفاف برای خودِ دراور تا پس‌زمینه اصلی دیده شود
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: OmniGlassContainer(
            // تمام محتوای دراور داخل یک ظرف شیشه‌ای یکپارچه
            borderRadius: 30,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                // --- بخش هدر کاربر ---
                _buildHeader(context),
                
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Divider(color: Colors.white12),
                ),

                // --- لیست آیتم‌های منو ---
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
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
                      _buildSectionLabel("Support"),
                      _buildDrawerItem(
                        icon: Icons.help_outline_rounded,
                        title: "Help Center",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                // --- بخش پاورقی (Logout) ---
                _buildDrawerItem(
                  icon: Icons.logout_rounded,
                  title: "Logout",
                  color: Colors.redAccent,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size: 50, color: Colors.white),
        ),
        const SizedBox(height: 15),
        const AdaptiveText(
          "Ahmad",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        AdaptiveText(
          "Senior Developer",
          fontSize: 12,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AdaptiveText(
        label.toUpperCase(),
        fontSize: 10,
        fontWeight: FontWeight.bold,
        style: const TextStyle(letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? Colors.blueAccent.withOpacity(0.8),
      ),
      title: AdaptiveText(
        title,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        style: color != null ? TextStyle(color: color) : null,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onTap: onTap,
    );
  }
}