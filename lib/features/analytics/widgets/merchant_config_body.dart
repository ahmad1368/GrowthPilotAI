import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/search_merchant_configs.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_config_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_view.dart';

/// Owns the merchant profile list and search query (Issue #338),
/// applying add/edit saves immediately to local state so the panel
/// reflects the new parameters without an app restart.
class MerchantConfigBody extends StatefulWidget {
  final List<MerchantConfigEntity> initialConfigs;

  const MerchantConfigBody({super.key, required this.initialConfigs});

  @override
  State<MerchantConfigBody> createState() => _MerchantConfigBodyState();
}

class _MerchantConfigBodyState extends State<MerchantConfigBody> {
  late List<MerchantConfigEntity> _configs = widget.initialConfigs;
  String _query = '';

  Future<void> _save({MerchantConfigEntity? existing}) async {
    final config =
        await showMerchantConfigDialog(context, existing: existing);
    if (config == null) return;
    final store = Get.find<ObjectBox>().store;
    final repo = MerchantConfigRepository(store.box<MerchantConfigEntity>());
    final savedId = repo.save(config);
    AuditLogRepository(store.box<AuditLogEntity>()).record(BuildAuditLogEntry.call(
      changeType: existing == null ? 'created profile' : 'updated profile',
      targetMerchant: config.businessName,
      previousValue: existing == null
          ? ''
          : '${existing.commissionRatePercent}% / \$${existing.transactionCapAmount}',
      newValue: '${config.commissionRatePercent}% / \$${config.transactionCapAmount}',
    ));
    setState(() {
      _configs = [
        for (final c in _configs)
          if (c.id != savedId) c,
        MerchantConfigEntity(
            id: savedId,
            businessName: config.businessName,
            businessId: config.businessId,
            commissionRatePercent: config.commissionRatePercent,
            transactionCapAmount: config.transactionCapAmount,
            notes: config.notes,
            updatedAt: config.updatedAt),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final allResults = SearchMerchantConfigs.call(_configs, '');
    final filteredResults = SearchMerchantConfigs.call(_configs, _query);
    return MerchantConfigView(
      filteredResults: filteredResults,
      allResults: allResults,
      onSearchChanged: (q) => setState(() => _query = q),
      onAddProfile: () => _save(),
      onEditProfile: (config) => _save(existing: config),
    );
  }
}
