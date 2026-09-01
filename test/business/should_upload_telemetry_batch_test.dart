import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_upload_telemetry_batch.dart';

void main() {
  final now = DateTime.utc(2027, 6, 15, 12);

  test('uploads immediately when nothing has ever been uploaded', () {
    expect(ShouldUploadTelemetryBatch.call(null, now), isTrue);
  });

  test('does not upload within the 48-hour window', () {
    expect(ShouldUploadTelemetryBatch.call(now.subtract(const Duration(hours: 10)), now), isFalse);
  });

  test('uploads once the 48-hour window has passed', () {
    expect(ShouldUploadTelemetryBatch.call(now.subtract(const Duration(hours: 48)), now), isTrue);
  });
}
