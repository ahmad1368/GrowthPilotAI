import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/cap_attribute_keys.dart';

void main() {
  test('leaves a map with 20 or fewer keys unchanged', () {
    final attrs = {for (var i = 0; i < 20; i++) 'k$i': 'v$i'};
    expect(CapAttributeKeys.call(attrs).length, 20);
  });

  test('truncates a map with more than 20 keys', () {
    final attrs = {for (var i = 0; i < 25; i++) 'k$i': 'v$i'};
    expect(CapAttributeKeys.call(attrs).length, 20);
  });
}
