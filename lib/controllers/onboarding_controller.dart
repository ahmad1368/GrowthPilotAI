import 'package:get/get.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Owns first-launch tour completion (Issue #162) — "finished" and
/// "skipped" are folded into one persisted flag since a skip must be
/// just as sticky as a completion (AC: "Dismissibility... saved").
class OnboardingController extends GetxController {
  static const _storageKey = 'onboarding_completed';

  bool hasCompletedOrSkipped = false;
  bool restored = false;

  Future<void> restore() async {
    final stored = await SecureStorageService.readData(_storageKey);
    hasCompletedOrSkipped = stored == 'true';
    restored = true;
  }

  Future<void> finish() async {
    hasCompletedOrSkipped = true;
    await SecureStorageService.writeData(_storageKey, 'true');
  }
}
