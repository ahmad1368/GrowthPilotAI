import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart'; // حتما اضافه شود
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/pages/main_wrapper.dart'; // برای دسترسی به NavigationController

/// Flat nav bar (Issue #5) — this repo's fixed no-BackdropFilter/no-glass
/// design rule (see AppDesignTokens) supersedes the issue's original
/// "Translucent"/glassmorphism styling; replaces the former OmniGlassPanel
/// wrapper with a flat, card-colored container.
class HomeBottomNav extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    // پارامتر onTap را حذف کردیم تا مستقیم با کنترلر کار کنیم
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: AppDesignTokens.card(brightness),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        border: Border.all(
          color:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          debugPrint("🟢 UI Level Click: $index");
          HapticFeedback.lightImpact();

          // پیدا کردن کنترلر و صدا زدن مستقیم متد
          final controller = Get.find<NavigationController>();
          controller.handleNavigation(index);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
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
    );
  }
}
