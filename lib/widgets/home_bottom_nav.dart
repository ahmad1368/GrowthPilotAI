import 'package:flutter/material.dart';
import 'package:get/get.dart'; // حتما اضافه شود
import 'package:growth_pilot_ai/pages/main_wrapper.dart'; // برای دسترسی به NavigationController
import 'omni_glass_panel.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    // پارامتر onTap را حذف کردیم تا مستقیم با کنترلر کار کنیم
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: OmniGlassPanel(
        isInteractive: true,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            debugPrint("🟢 UI Level Click: $index");

            // پیدا کردن کنترلر و صدا زدن مستقیم متد
            final controller = Get.find<NavigationController>();
            controller.handleNavigation(index);
          },
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).unselectedWidgetColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              label: 'Insights',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.document_scanner_rounded,
                  size: 28,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: 'Scan'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_rounded,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
