import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_sensitive_data_warning.dart';

void main() {
  test('warns when the draft looks like it contains a SIN', () {
    expect(DetectSensitiveDataWarning.call('my sin is 123-456-789'), isNotNull);
  });

  test('warns when the draft looks like it contains a valid card number', () {
    expect(DetectSensitiveDataWarning.call('4532015112830366'), isNotNull);
  });

  test('does not warn for ordinary text', () {
    expect(DetectSensitiveDataWarning.call('see you at 5pm'), isNull);
  });

  test('does not warn for empty text', () {
    expect(DetectSensitiveDataWarning.call(''), isNull);
  });
}
