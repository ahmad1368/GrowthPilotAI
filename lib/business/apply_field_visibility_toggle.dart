import 'package:growth_pilot_ai/business/toggle_field_visibility.dart';
import 'package:growth_pilot_ai/core/enum/contact_field.dart';
import 'package:growth_pilot_ai/core/models/business_contact_visibility.dart';

/// Applies [ToggleFieldVisibility] to whichever [ContactField] the user
/// tapped (Issue #218), leaving the other three fields untouched.
class ApplyFieldVisibilityToggle {
  static BusinessContactVisibility call(BusinessContactVisibility current, ContactField field) {
    switch (field) {
      case ContactField.phone:
        return BusinessContactVisibility(
          phone: ToggleFieldVisibility.call(current.phone),
          address: current.address,
          email: current.email,
          mapLocation: current.mapLocation,
        );
      case ContactField.address:
        return BusinessContactVisibility(
          phone: current.phone,
          address: ToggleFieldVisibility.call(current.address),
          email: current.email,
          mapLocation: current.mapLocation,
        );
      case ContactField.email:
        return BusinessContactVisibility(
          phone: current.phone,
          address: current.address,
          email: ToggleFieldVisibility.call(current.email),
          mapLocation: current.mapLocation,
        );
      case ContactField.mapLocation:
        return BusinessContactVisibility(
          phone: current.phone,
          address: current.address,
          email: current.email,
          mapLocation: ToggleFieldVisibility.call(current.mapLocation),
        );
    }
  }
}
