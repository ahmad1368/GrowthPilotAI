import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_invoice_line_items.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('builds a single line item from the accepted quote', () {
    final request = ProcurementRequestEntity(
        requesterId: 'buyer', sector: 'automotive', summary: 'Brake repair', budgetMin: 100,
        budgetMax: 200, centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: 'Whalley',
        deadline: now.add(const Duration(days: 1)), createdAt: now);
    final response = ProcurementResponseEntity(
        requestId: 1, providerId: 'vendor', quoteAmount: 150, message: 'Can do it', createdAt: now);

    final items = BuildInvoiceLineItems.call(request, response);

    expect(items, hasLength(1));
    expect(items.single.description, contains('automotive'));
    expect(items.single.description, contains('Brake repair'));
    expect(items.single.amount, 150);
  });
}
