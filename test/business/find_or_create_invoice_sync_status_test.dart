import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_or_create_invoice_sync_status.dart';
import 'package:growth_pilot_ai/core/data/entities/invoice_sync_status_entity.dart';

void main() {
  test('creates a new status row when none exists for this invoice', () {
    final status = FindOrCreateInvoiceSyncStatus.call([], 1);
    expect(status.invoiceId, 1);
    expect(status.id, 0);
  });

  test('reuses the existing row for the same invoice', () {
    final existing = InvoiceSyncStatusEntity(invoiceId: 1)..id = 5;
    final status = FindOrCreateInvoiceSyncStatus.call([existing], 1);
    expect(identical(status, existing), isTrue);
  });
}
