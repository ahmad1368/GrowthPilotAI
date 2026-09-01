import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_record_usage_event.dart';

void main() {
  group('ShouldRecordUsageEvent', () {
    test('true when data-usage consent is granted', () {
      expect(ShouldRecordUsageEvent.call(true), isTrue);
    });

    test('false when data-usage consent is not granted', () {
      expect(ShouldRecordUsageEvent.call(false), isFalse);
    });
  });
}
