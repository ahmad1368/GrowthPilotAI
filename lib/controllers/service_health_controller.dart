import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/aggregate_service_health_snapshot.dart';
import 'package:growth_pilot_ai/business/check_connectivity_health.dart';
import 'package:growth_pilot_ai/business/check_objectbox_store_health.dart';
import 'package:growth_pilot_ai/business/check_secure_storage_health.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/core/models/service_health_indicator.dart';
import 'package:growth_pilot_ai/services/connectivity_service.dart';

/// Drives the "System Health" diagnostics screen (Issue #166,
/// reinterpreted as a local dependency panel — see PR notes).
class ServiceHealthController extends GetxController {
  final indicators = <ServiceHealthIndicator>[].obs;
  final overallStatus = ServiceHealthStatus.up.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  Future<void> reload() async {
    isLoading.value = true;
    final results = <ServiceHealthIndicator>[
      CheckObjectBoxStoreHealth.call(Get.find<ObjectBox>()),
      CheckConnectivityHealth.call(Get.find<ConnectivityService>()),
      await CheckSecureStorageHealth.call(),
    ];
    indicators.assignAll(results);
    overallStatus.value = AggregateServiceHealthSnapshot.call(results);
    isLoading.value = false;
  }
}
