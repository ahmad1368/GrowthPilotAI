import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'omni_glass_panel.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNav(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // استفاده از UIHelper برای جلوگیری از کشیدگی بیش از حد در دسکتاپ
        width: UIHelper.getAdaptiveWidth(context),
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: OmniGlassPanel(
          opacity: 0.15, // غلظت بیشتر برای جداسازی از محتوای اسکرول شونده پشت
          isInteractive: true,
          fullBorderRadius: true,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor:
                theme.colorScheme.onSurface.withValues(alpha: 0.4),
            // استایل متن برای هماهنگی با AdaptiveText
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter', // یا هر فونتی که در پروژه ست کرده‌اید
            ),
            items: _buildItems(),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildItems() => const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded),
          label: 'Home',
          tooltip: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_rounded),
          label: 'Insights',
          tooltip: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons
              .security_rounded), // جایگزین پروفایل برای دسترسی سریع به وضعیت امنیت
          label: 'Security',
          tooltip: 'Data Protection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_suggest_rounded),
          label: 'Settings',
          tooltip: 'App Settings',
        ),
      ];
}
