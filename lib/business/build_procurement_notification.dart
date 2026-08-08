import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

/// "Real-time Notification" AC (Issue #126) — a generic "Market
/// Opportunity" alert per eligible provider, naming only the obfuscated
/// [ProcurementRequestEntity.neighborhood], never the requester's
/// identity or exact location.
class BuildProcurementNotification {
  static InboxNotificationEntity call(ProcurementRequestEntity request, DateTime now) {
    return InboxNotificationEntity(
      title: 'New market opportunity',
      body: 'A new ${request.sector} request is open near ${request.neighborhood}',
      metadataRefType: 'ProcurementRequest',
      metadataRefId: request.id.toString(),
      createdAt: now,
    );
  }
}
