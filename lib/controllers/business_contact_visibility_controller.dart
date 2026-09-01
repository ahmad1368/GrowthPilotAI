import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/apply_field_visibility_toggle.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_contact_visibility_repository.dart';
import 'package:growth_pilot_ai/core/enum/contact_field.dart';
import 'package:growth_pilot_ai/core/models/business_contact_visibility.dart';
import 'package:growth_pilot_ai/core/models/business_contact_visibility_mapper.dart';

/// Drives the "Contextual Privacy Switch" settings UI (Issue #218): loads
/// the business's contact-field visibility and applies inline toggles.
class BusinessContactVisibilityController extends GetxController {
  final BusinessContactVisibilityRepository _repository;
  late final Rx<BusinessContactVisibility> settings;
  int _rowId = 0;

  BusinessContactVisibilityController(this._repository);

  @override
  void onInit() {
    super.onInit();
    final entity = _repository.get();
    _rowId = entity.id;
    settings = entity.toModel().obs;
  }

  void toggle(ContactField field) {
    final updated = ApplyFieldVisibilityToggle.call(settings.value, field);
    _rowId = _repository.save(updated.toEntity(_rowId));
    settings.value = updated;
  }
}
