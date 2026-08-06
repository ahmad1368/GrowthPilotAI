import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_proposal_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/barter_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/barter_proposal_repository.dart';

/// Bundles the repositories the barter exchange marketplace needs
/// (Issue #413) — split out of the actions classes.
class BarterRepos {
  final store = Get.find<ObjectBox>().store;

  late final listings = BarterListingRepository(store.box<BarterListingEntity>());
  late final proposals = BarterProposalRepository(store.box<BarterProposalEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
