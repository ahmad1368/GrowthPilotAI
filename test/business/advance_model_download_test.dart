import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/advance_model_download.dart';
import 'package:growth_pilot_ai/core/enum/model_download_status.dart';
import 'package:growth_pilot_ai/core/models/model_download_state.dart';

void main() {
  group('AdvanceModelDownload', () {
    test('adds the new bytes and stays in the downloading status', () {
      final state = ModelDownloadState.notStarted(1000);
      final next = AdvanceModelDownload.call(state, 300);

      expect(next.downloadedBytes, 300);
      expect(next.status, ModelDownloadStatus.downloading);
    });

    test('clamps to totalBytes instead of overshooting', () {
      final state = ModelDownloadState.notStarted(1000);
      final next = AdvanceModelDownload.call(state, 5000);

      expect(next.downloadedBytes, 1000);
    });

    test('auto-completes once downloadedBytes reaches totalBytes', () {
      final state = ModelDownloadState.notStarted(1000);
      final next = AdvanceModelDownload.call(state, 1000);

      expect(next.status, ModelDownloadStatus.completed);
    });
  });
}
