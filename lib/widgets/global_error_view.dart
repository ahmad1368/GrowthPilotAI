import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// Flat error boundary view — replaces the former OmniGlassPanel card with
/// a plain flat container and fixes hardcoded white text/button colors
/// that only looked correct in dark mode.
class GlobalErrorView extends StatelessWidget {
  final FlutterErrorDetails details;

  const GlobalErrorView({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppDesignTokens.card(theme.brightness),
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.system_update_alt_rounded, // یا هر آیکون استاندارد دیگر
                  color: Colors.redAccent,
                  size: 60,
                ),
                const SizedBox(height: 20),
                Text(
                  "خطای غیرمنتظره در رابط کاربری",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  "متأسفانه در چیدمان این بخش مشکلی پیش آمده است. تیم فنی در حال بررسی خودکار این مورد است.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14, color: onSurface.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: onSurface.withValues(alpha: 0.08),
                    foregroundColor: onSurface,
                  ),
                  onPressed: () => Get.offAllNamed('/'), // بازگشت ایمن به خانه
                  child: const Text("تلاش مجدد و بازگشت به صفحه اصلی"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
