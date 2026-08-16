import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/model_download_status.dart';

/// Progress snapshot for the on-device AI model download (Issue #196) —
/// [totalBytes] matches the issue's ~1.5-2GB model size estimate.
@immutable
class ModelDownloadState {
  final ModelDownloadStatus status;
  final int downloadedBytes;
  final int totalBytes;

  const ModelDownloadState({
    required this.status,
    required this.downloadedBytes,
    required this.totalBytes,
  });

  factory ModelDownloadState.notStarted(int totalBytes) => ModelDownloadState(
        status: ModelDownloadStatus.notStarted,
        downloadedBytes: 0,
        totalBytes: totalBytes,
      );

  double get progress => totalBytes == 0 ? 0 : downloadedBytes / totalBytes;

  ModelDownloadState copyWith({ModelDownloadStatus? status, int? downloadedBytes}) =>
      ModelDownloadState(
        status: status ?? this.status,
        downloadedBytes: downloadedBytes ?? this.downloadedBytes,
        totalBytes: totalBytes,
      );
}
