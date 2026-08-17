import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/current_client_platform_label.dart';
import 'package:growth_pilot_ai/core/data/entities/breach_notification_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/breach_notification_log_repository.dart';

/// Appends one entry to the immutable breach-notification compliance
/// log (Issue #187) — no SendGrid/AWS SES/FCM dispatch exists to
/// trigger this (see PR notes); this is the record a real dispatcher
/// would write after sending.
class RecordBreachNotification {
  static void call(int incidentId, DateTime now) {
    GetIt.I<BreachNotificationLogRepository>().add(BreachNotificationLogEntity(
      incidentId: incidentId,
      notifiedAt: now,
      platform: CurrentClientPlatformLabel.call(),
    ));
  }
}
