import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/performance_tier.dart';
import 'package:growth_pilot_ai/core/services/performance_tier_service.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Owns the device's detected [PerformanceTier] and the user's "Power
/// Saver Mode" override (Issue #110, "User Control" constraint) —
/// [effectiveTier] is what every throttling decision in the app should
/// read, since it folds the manual override into the detected tier.
class PerformanceController extends GetxController {
  static const _storageKey = 'power_saver_enabled';

  final tier = PerformanceTier.mid.obs;
  final powerSaverEnabled = false.obs;

  PerformanceTier get effectiveTier =>
      powerSaverEnabled.value ? PerformanceTier.low : tier.value;

  /// Whether expensive `BackdropFilter` blur is safe to render (Issue
  /// #110's "Adaptive UI Strategy") — false on low tier / Power Saver Mode,
  /// so glass widgets fall back to a plain semi-transparent surface.
  bool get useBlur => effectiveTier != PerformanceTier.low;

  @override
  void onInit() {
    super.onInit();
    tier.value = PerformanceTierService.detect();
    _restorePowerSaverPreference();
  }

  Future<void> _restorePowerSaverPreference() async {
    final stored = await SecureStorageService.readData(_storageKey);
    powerSaverEnabled.value = stored == 'true';
  }

  Future<void> togglePowerSaver(bool enabled) async {
    powerSaverEnabled.value = enabled;
    await SecureStorageService.writeData(_storageKey, enabled.toString());
  }
}
