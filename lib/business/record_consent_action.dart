import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/current_client_platform_label.dart';
import 'package:growth_pilot_ai/core/data/entities/consent_log_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/consent_log_repository.dart';
import 'package:growth_pilot_ai/core/enum/consent_action.dart';

/// Appends one entry to the immutable consent audit trail (Issue #215).
class RecordConsentAction {
  static void call(ConsentAction action, String version, DateTime now) {
    GetIt.I<ConsentLogRepository>().add(ConsentLogEntity(
      dbAction: action.index,
      version: version,
      occurredAt: now,
      platform: CurrentClientPlatformLabel.call(),
    ));
  }
}
