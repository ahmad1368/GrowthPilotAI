import 'package:growth_pilot_ai/business/is_valid_document_file.dart';
import 'package:growth_pilot_ai/business/record_security_audit_event.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_status.dart';
import 'package:growth_pilot_ai/core/models/picked_document.dart';

/// "Link file metadata (filename, upload date) to the project's audit
/// log" (Issue #225) — validates first via [IsValidDocumentFile], then
/// appends an entry to #186's immutable security-audit trail either
/// way, so a rejected upload attempt is provable too. `owner` isn't
/// logged: this is a single-tenant local app with no multi-user
/// ownership concept (see PR notes).
class RecordDocumentUpload {
  static bool call(PickedDocument document, DateTime now) {
    final isValid = IsValidDocumentFile.call(document);
    RecordSecurityAuditEvent.call(
      SecurityAuditActionType.documentUploaded,
      isValid ? SecurityAuditStatus.success : SecurityAuditStatus.failure,
      now,
      metadata: '${document.fileName} (${document.sizeBytes} bytes)',
    );
    return isValid;
  }
}
