import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/group_purchase_body.dart';

/// Registers the Automated Group Buying and Volume Discount
/// Coordinator (Issue #414) as a pluggable report widget under id
/// `GROUP_BUYING_COORDINATOR` (#111).
class GroupPurchaseReportWidget extends BaseReportWidget {
  const GroupPurchaseReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return GroupPurchaseBody(purchases: data['purchases'] as List<GroupPurchaseEntity>);
  }
}
