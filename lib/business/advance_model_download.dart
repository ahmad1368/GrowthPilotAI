import 'package:growth_pilot_ai/core/enum/model_download_status.dart';
import 'package:growth_pilot_ai/core/models/model_download_state.dart';

/// Applies a chunk of newly-downloaded bytes to [current] (Issue #196) —
/// the step a real downloader's progress callback would drive. Clamps
/// to [ModelDownloadState.totalBytes] and auto-transitions to
/// [ModelDownloadStatus.completed] once fully downloaded, instead of
/// requiring every caller to check that separately.
class AdvanceModelDownload {
  static ModelDownloadState call(ModelDownloadState current, int newBytes) {
    final downloaded = (current.downloadedBytes + newBytes).clamp(0, current.totalBytes);
    final done = downloaded >= current.totalBytes;
    return current.copyWith(
      downloadedBytes: downloaded,
      status: done ? ModelDownloadStatus.completed : ModelDownloadStatus.downloading,
    );
  }
}
