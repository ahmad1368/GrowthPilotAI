import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';

/// Verifies a sponsored placement override is still backed by an
/// approved advertising request and records the check to the audit
/// trail (Issue #408, acceptance criterion 5), reusing
/// [BuildAuditLogEntry] (#343) so the verification itself can never be
/// altered after the fact.
class VerifySponsoredPlacement {
  static ({bool legitimate, AuditLogEntity log}) call(
      LeaderboardEntry entry, List<AdvertisingRequestEntity> requests) {
    final matches = requests.where((r) => r.id == entry.sourceRequestId);
    final source = matches.isEmpty ? null : matches.first;
    final legitimate = source != null && source.status == AdRequestStatus.approved;

    final log = BuildAuditLogEntry.call(
      changeType: 'verified sponsored leaderboard placement',
      targetMerchant: entry.name,
      newValue: legitimate
          ? 'legitimate: backed by approved request #${source.id}'
          : 'illegitimate: no matching approved advertising request',
    );

    return (legitimate: legitimate, log: log);
  }
}
