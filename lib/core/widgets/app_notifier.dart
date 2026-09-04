import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_design_tokens.dart';

/// [Issue #784] Status kind for [AppNotifier] — drives which icon/color a
/// notification carries so status is legible at a glance, not just from
/// reading the text.
enum AppNotificationType { success, warning, error, info }

/// [Issue #784] Icon-led notification helper: every snackbar surfaces a
/// status icon ahead of its text, instead of relying on color/text alone.
/// Flat card background (no BackdropFilter/blur — GetX's `barBlur`/
/// `overlayBlur` are left at their default 0).
class AppNotifier {
  static void show({
    required String title,
    required String message,
    AppNotificationType type = AppNotificationType.info,
  }) {
    final brightness =
        Get.context != null ? Theme.of(Get.context!).brightness : Brightness.dark;
    final (icon, color) = _styleFor(type, brightness);

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(icon, color: color),
      backgroundColor: AppDesignTokens.card(brightness),
      colorText: AppDesignTokens.textPrimary(brightness),
      margin: const EdgeInsets.all(AppDesignTokens.spaceLg),
      borderRadius: AppDesignTokens.radiusMd,
      duration: const Duration(seconds: 4),
    );
  }

  static (IconData, Color) _styleFor(
      AppNotificationType type, Brightness brightness) {
    return switch (type) {
      AppNotificationType.success => (
          Icons.check_circle_rounded,
          AppDesignTokens.success
        ),
      AppNotificationType.warning => (
          Icons.warning_amber_rounded,
          AppDesignTokens.secondary(brightness)
        ),
      AppNotificationType.error => (
          Icons.error_rounded,
          AppDesignTokens.error(brightness)
        ),
      AppNotificationType.info => (
          Icons.info_rounded,
          AppDesignTokens.primary(brightness)
        ),
    };
  }
}
