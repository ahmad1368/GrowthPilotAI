import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/search_security_audit_logs.dart';
import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/security_audit_log_repository.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';

/// Drives the security-audit-log viewer (Issue #186).
class SecurityAuditLogController extends GetxController {
  final SecurityAuditLogRepository _repository;
  final visibleLogs = <SecurityAuditLogEntity>[].obs;
  final _filterType = Rxn<SecurityAuditActionType>();

  SecurityAuditLogController(this._repository);

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  void reload() {
    visibleLogs.assignAll(
        SearchSecurityAuditLogs.call(_repository.getAll(), actionType: _filterType.value));
  }

  void filterByType(SecurityAuditActionType? actionType) {
    _filterType.value = actionType;
    reload();
  }
}
