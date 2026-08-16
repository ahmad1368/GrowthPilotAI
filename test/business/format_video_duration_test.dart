import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/format_video_duration.dart';

void main() {
  group('FormatVideoDuration', () {
    test('formats minutes:seconds under an hour', () {
      expect(FormatVideoDuration.call(const Duration(minutes: 8, seconds: 40)), '8:40');
    });

    test('pads seconds under 10', () {
      expect(FormatVideoDuration.call(const Duration(minutes: 3, seconds: 5)), '3:05');
    });

    test('includes hours once the video is an hour or longer', () {
      expect(FormatVideoDuration.call(const Duration(hours: 1, minutes: 2, seconds: 3)), '1:02:03');
    });
  });
}
