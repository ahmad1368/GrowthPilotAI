import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/toggle_field_visibility.dart';
import 'package:growth_pilot_ai/core/enum/field_visibility.dart';

void main() {
  group('ToggleFieldVisibility', () {
    test('flips public to private', () {
      expect(ToggleFieldVisibility.call(FieldVisibility.public), FieldVisibility.private);
    });

    test('flips private to public', () {
      expect(ToggleFieldVisibility.call(FieldVisibility.private), FieldVisibility.public);
    });
  });
}
