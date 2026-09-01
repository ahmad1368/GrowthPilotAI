import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_field_visible_to_requester.dart';
import 'package:growth_pilot_ai/core/enum/field_visibility.dart';

void main() {
  group('IsFieldVisibleToRequester', () {
    test('a public field is visible to anyone', () {
      expect(IsFieldVisibleToRequester.call(FieldVisibility.public, false), isTrue);
    });

    test('a private field is hidden from a non-approved requester', () {
      expect(IsFieldVisibleToRequester.call(FieldVisibility.private, false), isFalse);
    });

    test('a private field is visible to an approved connection', () {
      expect(IsFieldVisibleToRequester.call(FieldVisibility.private, true), isTrue);
    });
  });
}
