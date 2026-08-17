import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/security_incident_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/security_incident_repository.dart';

/// Drives the "Security Advisory" public-notice viewer (Issue #187, AC:
/// "A Security Advisory page is ready... to host public notices").
class SecurityIncidentController extends GetxController {
  final SecurityIncidentRepository _repository;
  final incidents = <SecurityIncidentEntity>[].obs;

  SecurityIncidentController(this._repository);

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  void reload() => incidents.assignAll(_repository.getAll());
}
