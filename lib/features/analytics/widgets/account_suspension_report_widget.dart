import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/account_suspension_body.dart';

/// Registers the Temporary Account Suspension Module (Issue #341) as a
/// pluggable report widget under id `ACCOUNT_SUSPENSION_MODULE` (#111).
class AccountSuspensionReportWidget extends BaseReportWidget {
  const AccountSuspensionReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AccountSuspensionBody(
      initialSuspensions: data['suspensions'] as List<AccountSuspensionEntity>,
    );
  }
}
