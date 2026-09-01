import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_field_visibility_toggle.dart';
import 'package:growth_pilot_ai/core/enum/contact_field.dart';
import 'package:growth_pilot_ai/core/enum/field_visibility.dart';
import 'package:growth_pilot_ai/core/models/business_contact_visibility.dart';

void main() {
  group('ApplyFieldVisibilityToggle', () {
    const initial = BusinessContactVisibility(
      phone: FieldVisibility.private,
      address: FieldVisibility.private,
      email: FieldVisibility.private,
      mapLocation: FieldVisibility.private,
    );

    test('toggles only the targeted field', () {
      final updated = ApplyFieldVisibilityToggle.call(initial, ContactField.phone);

      expect(updated.phone, FieldVisibility.public);
      expect(updated.address, FieldVisibility.private);
      expect(updated.email, FieldVisibility.private);
      expect(updated.mapLocation, FieldVisibility.private);
    });

    test('toggling mapLocation leaves the others untouched', () {
      final updated = ApplyFieldVisibilityToggle.call(initial, ContactField.mapLocation);

      expect(updated.mapLocation, FieldVisibility.public);
      expect(updated.phone, FieldVisibility.private);
    });
  });
}
