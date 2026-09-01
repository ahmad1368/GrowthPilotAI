import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/fee_waiver_record_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/wholesale_order_repository.dart';

/// Bundles the repositories the zero-commission incentive engine
/// needs (Issue #420) — reuses [WholesaleOrderRepository] (#411) as
/// the transaction source, mirroring [MicroCreditRepos]'s
/// cross-feature reuse pattern.
class FeeWaiverRepos {
  final store = Get.find<ObjectBox>().store;

  late final orders = WholesaleOrderRepository(store.box<WholesaleOrderEntity>());
  late final records = FeeWaiverRecordRepository(store.box<FeeWaiverRecordEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
