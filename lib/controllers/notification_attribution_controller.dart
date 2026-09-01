import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/deserialize_notification_attribution.dart';
import 'package:growth_pilot_ai/business/is_attribution_window_active.dart';
import 'package:growth_pilot_ai/business/serialize_notification_attribution.dart';
import 'package:growth_pilot_ai/core/data/entities/notification_conversion_event_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/notification_conversion_repository.dart';
import 'package:growth_pilot_ai/core/enum/conversion_status.dart';
import 'package:growth_pilot_ai/core/models/notification_attribution.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Client-side attribution session (Issue #161): Last-Click, 24h window.
class NotificationAttributionController extends GetxController {
  static const _storageKey = 'notification_attribution';
  late final NotificationConversionRepository _repository;

  final Rx<NotificationAttribution?> current = Rx(null);

  @override
  void onInit() {
    super.onInit();
    _repository = GetIt.I<NotificationConversionRepository>();
    SecureStorageService.readData(_storageKey)
        .then((stored) => current.value = DeserializeNotificationAttribution.call(stored));
  }

  Future<void> recordOpen(int alertId, String category) async {
    final attribution =
        NotificationAttribution(alertId: alertId, category: category, attributedAt: DateTime.now());
    current.value = attribution;
    await SecureStorageService.writeData(
        _storageKey, SerializeNotificationAttribution.call(attribution));
    _logEvent(alertId, category, ConversionStatus.opened);
  }

  void recordConversion(ConversionStatus status) {
    final attribution = current.value;
    if (attribution == null) return;
    if (!IsAttributionWindowActive.call(attribution.attributedAt, DateTime.now())) return;
    _logEvent(attribution.alertId, attribution.category, status);
  }

  void _logEvent(int alertId, String category, ConversionStatus status) => _repository.add(
      NotificationConversionEventEntity(
          alertId: alertId, category: category, dbStatus: status.index, occurredAt: DateTime.now()));
}
