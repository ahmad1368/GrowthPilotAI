import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'omni_glass_container.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    // ۱. دریافت وضعیت فعلی تم
    final mode = AdaptiveTheme.of(context).mode;
    final isDark = mode.isDark;

    return Semantics(
      label: isDark ? "Switch to Day Mode" : "Switch to Night Mode",
      child: GestureDetector(
        onTap: () {
          // تغییر تم و ایجاد لرزش ملایم (Haptic)
          AdaptiveTheme.of(context).toggleThemeMode();
          HapticFeedback.mediumImpact();
        },
        child: OmniGlassContainer(
          // استفاده از ویجت شیشه‌ای خودمان با ابعاد کوچک برای سوئیچ
          borderRadius: 25,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          blur: 10, // بلور کمتر برای ابعاد کوچک
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 60,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // ایجاد هاله‌ای رنگی متناسب با وضعیت روز یا شب
              color: isDark 
                  ? Colors.blueGrey.withOpacity(0.1) 
                  : Colors.orangeAccent.withOpacity(0.1),
            ),
            child: Stack(
              children: [
                // انیمیشن جابه‌جایی گوی (Thumb)
                AnimatedAlign(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutBack,
                  alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.blueAccent.withOpacity(0.5) : Colors.orangeAccent.withOpacity(0.3),
                          blurRadius: 8,
                        )
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                      child: Icon(
                        isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                        key: ValueKey(isDark),
                        size: 16,
                        color: isDark ? Colors.indigo : Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}