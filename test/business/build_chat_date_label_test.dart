import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_chat_date_label.dart';

void main() {
  final now = DateTime(2026, 3, 15, 9, 30);

  test('labels a message sent today as "Today"', () {
    expect(BuildChatDateLabel.call(DateTime(2026, 3, 15, 8), now), 'Today');
  });

  test('labels a message sent yesterday as "Yesterday"', () {
    expect(BuildChatDateLabel.call(DateTime(2026, 3, 14, 23, 59), now), 'Yesterday');
  });

  test('labels an older message with an ISO-ish date', () {
    expect(BuildChatDateLabel.call(DateTime(2026, 3, 1), now), '2026-03-01');
  });
}
