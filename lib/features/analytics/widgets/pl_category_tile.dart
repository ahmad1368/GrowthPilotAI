import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/pl_category_breakdown.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One expense category row, expandable to its individual line items
/// (Issue #355's "drill-down... directly from high-level P&L summary").
class PLCategoryTile extends StatelessWidget {
  final PLCategoryBreakdown breakdown;

  const PLCategoryTile({super.key, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(breakdown.categoryName,
                  overflow: TextOverflow.ellipsis)),
          Text(CurrencyFormat.cad(breakdown.total)),
        ],
      ),
      children: [
        for (final tx in breakdown.transactions)
          ListTile(
            dense: true,
            title: Text(tx.description),
            subtitle: Text(tx.date.toString().split(' ').first),
            trailing: Text(CurrencyFormat.cad(tx.amount)),
          ),
      ],
    );
  }
}
