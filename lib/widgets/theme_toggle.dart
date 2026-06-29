import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = AdaptiveTheme.of(context).mode.isDark;

    return GestureDetector(
      onTap: () {
        if (isDark) {
          AdaptiveTheme.of(context).setLight();
        } else {
          AdaptiveTheme.of(context).setDark();
        }
      },
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
    );
  }
}
