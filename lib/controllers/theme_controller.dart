import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';

/// Encapsulates AdaptiveTheme toggle logic behind a service layer (Issue
/// #2 AC), instead of screens calling `AdaptiveTheme.of(context)` directly.
class ThemeController extends GetxController {
  void toggleTheme() {
    final adaptiveTheme = AdaptiveTheme.of(Get.context!);
    if (adaptiveTheme.mode.isDark) {
      adaptiveTheme.setLight();
    } else {
      adaptiveTheme.setDark();
    }
  }

  void setSystemTheme() {
    AdaptiveTheme.of(Get.context!).setSystem();
  }
}
