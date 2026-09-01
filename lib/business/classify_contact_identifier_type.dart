import 'package:growth_pilot_ai/core/enum/contact_identifier_type.dart';

/// Classifies a raw contact identifier as a phone number or email
/// (Issue #542, acceptance criterion 3).
class ClassifyContactIdentifierType {
  static ContactIdentifierType call(String identifier) =>
      identifier.contains('@') ? ContactIdentifierType.email : ContactIdentifierType.phone;
}
