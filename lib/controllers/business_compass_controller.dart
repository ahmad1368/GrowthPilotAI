import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_business_compass_metrics.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_period.dart';
import 'package:growth_pilot_ai/business/get_sector_benchmark.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/transaction_repository.dart';
import 'package:growth_pilot_ai/core/enum/business_sector.dart';
import 'package:growth_pilot_ai/core/enum/compass_period.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';

/// Drives the Business Compass screen (Issue #84): computes the user's own
/// "Success DNA" vector from local transactions and compares it against a
/// mocked sector benchmark (Issue #83), since no backend analysis pipeline
/// exists in this repo.
class BusinessCompassController extends GetxController {
  late TransactionRepository _transactions;

  final selectedSector = BusinessSector.tech.obs;
  final selectedPeriod = CompassPeriod.monthly.obs;
  final userMetrics = const BusinessCompassMetrics(
    liquidityRatio: 0,
    burnVelocity: 0.5,
    vendorDiversity: 0,
    paymentPunctuality: 0,
    profitMargin: 0,
  ).obs;
  DateTime lastUpdatedAt = DateTime.now();

  BusinessCompassMetrics get sectorMetrics =>
      GetSectorBenchmark.call(selectedSector.value);

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _transactions = TransactionRepository(store.box<TransactionEntity>());
    _recompute();
  }

  void changeSector(BusinessSector sector) {
    selectedSector.value = sector;
  }

  void changePeriod(CompassPeriod period) {
    selectedPeriod.value = period;
    _recompute();
  }

  void _recompute() {
    final windowed = FilterTransactionsByPeriod.call(
        _transactions.getAll(), selectedPeriod.value, DateTime.now());
    userMetrics.value = ComputeBusinessCompassMetrics.call(windowed);
    lastUpdatedAt = DateTime.now();
  }
}
