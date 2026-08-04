import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/daily_cap_body.dart';

/// Registers the Daily Transaction Cap Engine (Issue #344) as a
/// pluggable report widget under id `DAILY_TRANSACTION_CAP_ENGINE`
/// (#111).
class DailyCapReportWidget extends BaseReportWidget {
  const DailyCapReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return DailyCapBody(
      transactions: data['transactions'] as List<TransactionEntity>,
      initialCapAmount: data['capAmount'] as double,
      initialRequests: data['requests'] as List<CapExpansionRequestEntity>,
    );
  }
}
