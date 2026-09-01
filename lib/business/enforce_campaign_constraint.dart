import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/enum/campaign_constraint_status.dart';

/// Auto-deactivates an approved request once it's no longer active
/// (Issue #409, acceptance criteria 1-3) — returns null when there is
/// nothing to do, so the caller only persists when a real transition
/// happens, with an audit entry recording why (mirroring
/// [VerifySponsoredPlacement]'s #408 audit pattern).
class EnforceCampaignConstraint {
  static ({AdvertisingRequestEntity request, AuditLogEntity log})? call(
      AdvertisingRequestEntity request, CampaignConstraintStatus status) {
    if (status == CampaignConstraintStatus.active) return null;
    if (request.status != AdRequestStatus.approved) return null;

    final updated = AdvertisingRequestEntity(
      id: request.id,
      merchantName: request.merchantName,
      category: request.category,
      dbPackageType: request.dbPackageType,
      dbStatus: AdRequestStatus.denied.index,
      requestedAt: request.requestedAt,
    );
    final log = BuildAuditLogEntry.call(
      changeType: 'auto-deactivated: ${status.name}',
      targetMerchant: request.merchantName,
      previousValue: 'approved',
      newValue: 'denied (${status.name})',
    );
    return (request: updated, log: log);
  }
}
