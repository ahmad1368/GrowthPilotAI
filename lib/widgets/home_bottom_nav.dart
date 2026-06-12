import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/navigation/controllers/navigation_controller.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final navControl = Get.find<NavigationController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // تنظیم رنگ‌های مسطح و انترپرایز پروژه
    final bgColor = isDark ? const Color(0xff09090b) : const Color(0xffffffff);
    final activeColor =
        isDark ? const Color(0xffffffff) : const Color(0xff09090b);
    final inactiveColor =
        isDark ? const Color(0xff27272a) : const Color(0xffe4e4e7);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          top: BorderSide(
              color:
                  isDark ? const Color(0xff27272a) : const Color(0xffe4e4e7)),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => navControl.handleNavigation(index),
        backgroundColor: bgColor,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.space_dashboard_outlined),
            activeIcon: Icon(Icons.space_dashboard),
            label: 'داشبورد',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'تحلیل‌ها',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner_outlined),
            activeIcon: Icon(Icons.document_scanner),
            label: 'اسکنر AI',
          ),
        ],
      ),
    );
  }
}
