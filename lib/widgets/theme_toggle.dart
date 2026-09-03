import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AdaptiveTheme.of(context).mode.isDark;

    return Semantics(
      label: isDark ? "Switch to Light Mode" : "Switch to Dark Mode",
      button: true,
      toggled: isDark,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Issue #2 AC: route through the ThemeController service layer
          // instead of calling AdaptiveTheme.of(context) directly.
          Get.find<ThemeController>().toggleTheme();
          HapticFeedback.mediumImpact();
        },
        // Issue #7 AC: minimum 44x44 tappable hit area even though the
        // pill's own visual size is more compact.
        child: Container(
          constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 60,
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // استفاده از متد جدید برای شفافیت پس‌زمینه سوئیچ
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark ? Colors.cyanAccent : Colors.orangeAccent,
                  boxShadow: [
                    BoxShadow(
                      color: (isDark ? Colors.cyanAccent : Colors.orangeAccent)
                          .withValues(alpha: 0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  size: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
