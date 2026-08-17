import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/field_visibility.dart';

const _defaultVisibility = 1; // FieldVisibility.private.index — Privacy by Design (AC)

/// Single-row visibility settings for the business's contact fields
/// (Issue #218) — every field defaults to private for new accounts (AC:
/// "Privacy by Design").
@Entity()
class BusinessContactVisibilityEntity {
  @Id()
  int id = 0;

  int dbPhoneVisibility;
  int dbAddressVisibility;
  int dbEmailVisibility;
  int dbMapLocationVisibility;

  BusinessContactVisibilityEntity({
    this.id = 0,
    this.dbPhoneVisibility = _defaultVisibility,
    this.dbAddressVisibility = _defaultVisibility,
    this.dbEmailVisibility = _defaultVisibility,
    this.dbMapLocationVisibility = _defaultVisibility,
  });

  FieldVisibility get phoneVisibility => FieldVisibility.values[dbPhoneVisibility];
  FieldVisibility get addressVisibility => FieldVisibility.values[dbAddressVisibility];
  FieldVisibility get emailVisibility => FieldVisibility.values[dbEmailVisibility];
  FieldVisibility get mapLocationVisibility => FieldVisibility.values[dbMapLocationVisibility];
}
