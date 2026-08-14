import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_payment_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/ad_campaign_constraint_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/ad_payment_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/advertising_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';

/// Bundles the repositories the payment activation dashboard needs
/// (Issue #410) — split out of [AdPaymentActions].
class AdPaymentRepos {
  final store = Get.find<ObjectBox>().store;

  late final payments = AdPaymentRepository(store.box<AdPaymentEntity>());
  late final constraints =
      AdCampaignConstraintRepository(store.box<AdCampaignConstraintEntity>());
  late final requests = AdvertisingRequestRepository(store.box<AdvertisingRequestEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
