import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/model_download_status.dart';
import 'package:growth_pilot_ai/core/models/model_download_state.dart';

void main() {
  group('ModelDownloadState', () {
    test('notStarted begins at zero progress', () {
      final state = ModelDownloadState.notStarted(1000);
      expect(state.progress, 0);
      expect(state.status, ModelDownloadStatus.notStarted);
    });

    test('progress is the downloaded/total fraction', () {
      const state = ModelDownloadState(
          status: ModelDownloadStatus.downloading, downloadedBytes: 250, totalBytes: 1000);
      expect(state.progress, 0.25);
    });

    test('a zero-byte total does not divide by zero', () {
      const state =
          ModelDownloadState(status: ModelDownloadStatus.notStarted, downloadedBytes: 0, totalBytes: 0);
      expect(state.progress, 0);
    });

    test('copyWith preserves totalBytes while updating the given fields', () {
      final state = ModelDownloadState.notStarted(1000)
          .copyWith(status: ModelDownloadStatus.downloading, downloadedBytes: 500);
      expect(state.totalBytes, 1000);
      expect(state.downloadedBytes, 500);
      expect(state.status, ModelDownloadStatus.downloading);
    });
  });
}
