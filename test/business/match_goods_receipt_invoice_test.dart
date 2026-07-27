import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/match_goods_receipt_invoice.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';

GoodsReceiptEntity _receipt({
  PurchaseOrderEntity? order,
  String receivedItemsSummary = 'Flour x16',
  String damagedOrMissingNotes = '',
  String invoiceReference = 'INV-1',
  required double invoiceAmount,
  required DateTime receivedAt,
}) {
  final receipt = GoodsReceiptEntity(
    receivedItemsSummary: receivedItemsSummary,
    damagedOrMissingNotes: damagedOrMissingNotes,
    invoiceReference: invoiceReference,
    invoiceAmount: invoiceAmount,
    receivedAt: receivedAt,
  );
  if (order != null) receipt.purchaseOrder.target = order;
  return receipt;
}

void main() {
  test('flags an invoice amount matching the order total as matched', () {
    final order = PurchaseOrderEntity(
        vendorName: 'Acme Supplies',
        itemsSummary: 'Flour x16',
        estimatedTotal: 48.0,
        createdAt: DateTime(2026, 1, 1));
    final results = MatchGoodsReceiptInvoice.call(
        [_receipt(order: order, invoiceAmount: 48.0, receivedAt: DateTime(2026, 1, 5))]);

    expect(results.single.isMatched, isTrue);
    expect(results.single.vendorName, 'Acme Supplies');
  });

  test('flags a discrepancy when the invoice amount differs from the order total', () {
    final order = PurchaseOrderEntity(
        vendorName: 'Acme Supplies',
        itemsSummary: 'Flour x16',
        estimatedTotal: 48.0,
        createdAt: DateTime(2026, 1, 1));
    final results = MatchGoodsReceiptInvoice.call(
        [_receipt(order: order, invoiceAmount: 60.0, receivedAt: DateTime(2026, 1, 5))]);

    expect(results.single.isMatched, isFalse);
    expect(results.single.variance, 12.0);
  });

  test('leaves orderEstimatedTotal null when the receipt has no linked purchase order', () {
    final results =
        MatchGoodsReceiptInvoice.call([_receipt(invoiceAmount: 48.0, receivedAt: DateTime(2026, 1, 5))]);

    expect(results.single.orderEstimatedTotal, isNull);
    expect(results.single.variance, isNull);
    expect(results.single.isMatched, isFalse);
    expect(results.single.vendorName, isEmpty);
  });

  test('reports damaged or missing notes when present', () {
    final results = MatchGoodsReceiptInvoice.call([
      _receipt(
          invoiceAmount: 48.0,
          receivedAt: DateTime(2026, 1, 5),
          damagedOrMissingNotes: '2 bags torn'),
    ]);

    expect(results.single.hasDamagedOrMissing, isTrue);
  });

  test('sorts receipts most-recent first', () {
    final results = MatchGoodsReceiptInvoice.call([
      _receipt(invoiceAmount: 10.0, receivedAt: DateTime(2026, 1, 1), invoiceReference: 'old'),
      _receipt(invoiceAmount: 20.0, receivedAt: DateTime(2026, 1, 10), invoiceReference: 'new'),
    ]);

    expect(results.map((r) => r.invoiceReference), ['new', 'old']);
  });
}
