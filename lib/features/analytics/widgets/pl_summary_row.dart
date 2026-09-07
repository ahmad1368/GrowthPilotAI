import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/locale_controller.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/core/models/pl_summary.dart';
import 'package:growth_pilot_ai/core/utils/locale_number_format.dart';

/// Income / Expense / Net Profit stat row for the P&L widget (Issue #355).
/// Net profit turns the theme's error color when negative.
///
/// [Issue #813] Labels and amounts now follow the active [LocaleController]
/// locale (via `.tr` and [LocaleNumberFormat]) instead of hardcoded English
/// text and a CAD-only formatter — this is the app's reference example for
/// how a stat widget should be wired for localization.
class PLSummaryRow extends StatelessWidget {
  final PLSummary summary;

  const PLSummaryRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final netColor = summary.netProfit < 0 ? scheme.error : scheme.primary;
    return Obx(() {
      final locale = Get.find<LocaleController>().current.value;
      return Row(
        children: [
          _stat(context, 'pl_summary_income'.tr, summary.totalIncome, scheme.onSurface, locale),
          _stat(context, 'pl_summary_expenses'.tr, summary.totalExpense, scheme.onSurface, locale),
          _stat(context, 'pl_summary_net_profit'.tr, summary.netProfit, netColor, locale),
        ],
      );
    });
  }

  Widget _stat(BuildContext context, String label, double value, Color color, AppLocale locale) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          Text(LocaleNumberFormat.currency(value, locale),
              style: TextStyle(color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
