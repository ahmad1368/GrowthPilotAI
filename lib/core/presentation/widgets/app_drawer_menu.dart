import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/settings/presentation/widgets/settings_page.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppDrawerMenu extends StatelessWidget {
  const AppDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        _buildItem(context, Icons.dashboard_rounded, "Dashboard", iconColor,
            () => Navigator.pop(context)),
        _buildItem(context, Icons.analytics_rounded, "Growth Metrics",
            iconColor, () {}),
        _buildItem(context, Icons.cloud_done_rounded, "Azure Status", iconColor,
            () {}),
        _buildItem(context, Icons.security_rounded, "Security Center",
            iconColor, () {}),
        if (kDebugMode) ...[
          const Divider(color: Colors.white10),
          _buildItem(
            context,
            Icons.settings_input_component_rounded,
            "Connection Settings",
            Colors.orangeAccent,
            () {
              Navigator.pop(context);
              Get.to(() => const SettingsPage());
            },
          ),
        ],
        const Divider(color: Colors.white10, height: 40),
        _buildItem(
            context, Icons.logout_rounded, "Logout", Colors.redAccent, () {}),
      ],
    );
  }

  Widget _buildItem(
    BuildContext ctx,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        title,
        style: ShadTheme.of(ctx).textTheme.p.copyWith(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: onTap,
    );
  }
}
