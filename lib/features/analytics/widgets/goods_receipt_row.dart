import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/goods_receipt_match_record.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_damaged_badge.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_match_badge.dart';

/// One goods-receipt row (Issue #444): what arrived, an invoice-match
/// badge, and a damaged/missing flag when applicable.
class GoodsReceiptRow extends StatelessWidget {
  final GoodsReceiptMatchRecord match;

  const GoodsReceiptRow({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final matched = match.orderEstimatedTotal == null ? null : match.isMatched;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    match.vendorName.isEmpty
                        ? match.receivedItemsSummary
                        : '${match.vendorName}: ${match.receivedItemsSummary}',
                    overflow: TextOverflow.ellipsis),
                Text(CurrencyFormat.cad(match.invoiceAmount),
                    style: TextStyle(
                        fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GoodsReceiptMatchBadge(matched: matched),
              if (match.hasDamagedOrMissing)
                const Padding(
                    padding: EdgeInsets.only(top: 4), child: GoodsReceiptDamagedBadge()),
            ],
          ),
        ],
      ),
    );
  }
}
