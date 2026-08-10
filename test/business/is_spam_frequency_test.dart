import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_spam_frequency.dart';

void main() {
  test('flags an account posting above the default hourly threshold', () {
    expect(IsSpamFrequency.call(21), isTrue);
  });

  test('does not flag a normal posting rate', () {
    expect(IsSpamFrequency.call(5), isFalse);
    expect(IsSpamFrequency.call(20), isFalse);
  });

  test('respects a custom threshold', () {
    expect(IsSpamFrequency.call(5, maxPostsPerHour: 3), isTrue);
  });
}
