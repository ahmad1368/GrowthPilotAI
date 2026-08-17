import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/field_visibility.dart';

/// The business's contact-field visibility settings (Issue #218) —
/// mirrors [BusinessContactVisibilityEntity].
@immutable
class BusinessContactVisibility {
  final FieldVisibility phone;
  final FieldVisibility address;
  final FieldVisibility email;
  final FieldVisibility mapLocation;

  const BusinessContactVisibility({
    required this.phone,
    required this.address,
    required this.email,
    required this.mapLocation,
  });
}
