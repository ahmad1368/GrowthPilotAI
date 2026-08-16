import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/advance_model_download.dart';
import 'package:growth_pilot_ai/core/enum/model_download_status.dart';
import 'package:growth_pilot_ai/core/models/model_download_state.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Owns the on-device AI model's consent + download state (Issue #196
/// scaffolding) — [downloadedBytes] only ever advances via
/// [reportProgress], which nothing calls yet since no real downloader
/// is wired up (see PR notes); pause/resume/consent are fully real.
class AiEngineController extends GetxController {
  static const modelSizeBytes = 2 * 1024 * 1024 * 1024; // ~2GB, per the issue's estimate
  static const _consentStorageKey = 'ai_engine_download_consent';

  final hasConsented = false.obs;
  final downloadState = ModelDownloadState.notStarted(modelSizeBytes).obs;

  @override
  void onInit() {
    super.onInit();
    SecureStorageService.readData(_consentStorageKey)
        .then((stored) => hasConsented.value = stored == 'true');
  }

  Future<void> grantConsent() async {
    hasConsented.value = true;
    await SecureStorageService.writeData(_consentStorageKey, 'true');
  }

  void startDownload() {
    downloadState.value = downloadState.value.copyWith(status: ModelDownloadStatus.downloading);
  }

  void pause() {
    if (downloadState.value.status != ModelDownloadStatus.downloading) return;
    downloadState.value = downloadState.value.copyWith(status: ModelDownloadStatus.paused);
  }

  void resume() {
    if (downloadState.value.status != ModelDownloadStatus.paused) return;
    downloadState.value = downloadState.value.copyWith(status: ModelDownloadStatus.downloading);
  }

  void reportProgress(int newBytes) {
    downloadState.value = AdvanceModelDownload.call(downloadState.value, newBytes);
  }
}
