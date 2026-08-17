import 'package:growth_pilot_ai/core/data/entities/business_contact_visibility_entity.dart';
import 'package:growth_pilot_ai/core/models/business_contact_visibility.dart';

/// [BusinessContactVisibilityEntity] <-> [BusinessContactVisibility]
/// conversions (Issue #218).
extension BusinessContactVisibilityMapper on BusinessContactVisibilityEntity {
  BusinessContactVisibility toModel() => BusinessContactVisibility(
        phone: phoneVisibility,
        address: addressVisibility,
        email: emailVisibility,
        mapLocation: mapLocationVisibility,
      );
}

extension BusinessContactVisibilityEntityMapper on BusinessContactVisibility {
  BusinessContactVisibilityEntity toEntity(int id) => BusinessContactVisibilityEntity(
        id: id,
        dbPhoneVisibility: phone.index,
        dbAddressVisibility: address.index,
        dbEmailVisibility: email.index,
        dbMapLocationVisibility: mapLocation.index,
      );
}
