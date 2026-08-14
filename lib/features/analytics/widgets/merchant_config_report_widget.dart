import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_body.dart';

/// Registers the Single-User Granular Configuration Panel (Issue #338),
/// now also surfacing each profile's trust score (Issue #347), as a
/// pluggable report widget under id `MERCHANT_CONFIG_PANEL` (#111).
class MerchantConfigReportWidget extends BaseReportWidget {
  const MerchantConfigReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return MerchantConfigBody(
      initialConfigs: data['configs'] as List<MerchantConfigEntity>,
      suspensions: data['suspensions'] as List<AccountSuspensionEntity>,
      restrictions: data['restrictions'] as List<ServiceRestrictionEntity>,
      auditLogs: data['logs'] as List<AuditLogEntity>,
    );
  }
}
