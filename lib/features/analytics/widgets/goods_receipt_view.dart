import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/match_goods_receipt_invoice.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders goods-receipt rows + a record-receipt button (Issue #444).
/// Purely presentational — [GoodsReceiptBody] owns the receipt list.
class GoodsReceiptView extends StatelessWidget {
  final List<GoodsReceiptEntity> receipts;
  final VoidCallback onRecordReceipt;

  const GoodsReceiptView({super.key, required this.receipts, required this.onRecordReceipt});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final matches = MatchGoodsReceiptInvoice.call(receipts);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Matched against purchase-order invoices',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onRecordReceipt,
              child: Text('+ Record Receipt', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (matches.isEmpty)
          const Text('No goods receipts recorded yet.')
        else
          for (final m in matches) GoodsReceiptRow(match: m),
      ],
    );
  }
}
