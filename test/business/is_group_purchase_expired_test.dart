import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_group_purchase_expired.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/core/enum/group_purchase_status.dart';

GroupPurchaseEntity _purchase({required GroupPurchaseStatus status}) {
  return GroupPurchaseEntity(
    id: 1,
    organizerName: 'Organizer',
    itemName: 'Item',
    itemDescription: '',
    unitPrice: 1,
    minQuantityThreshold: 10,
    dbStatus: status.index,
    deadline: DateTime(2026, 1, 15),
    createdAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('an open campaign past its deadline is expired', () {
    expect(IsGroupPurchaseExpired.call(_purchase(status: GroupPurchaseStatus.open), DateTime(2026, 1, 16)),
        true);
  });

  test('an open campaign before its deadline is not expired', () {
    expect(IsGroupPurchaseExpired.call(_purchase(status: GroupPurchaseStatus.open), DateTime(2026, 1, 10)),
        false);
  });

  test('a finalized campaign is never expired even past the deadline', () {
    expect(
        IsGroupPurchaseExpired.call(_purchase(status: GroupPurchaseStatus.finalized), DateTime(2026, 1, 16)),
        false);
  });
}
