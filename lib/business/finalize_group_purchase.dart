import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/core/enum/group_purchase_status.dart';

/// Locks in the consolidated bulk order once the organizer finalizes
/// a campaign that met its threshold (Issue #414, acceptance
/// criterion 3) — the caller routes the order/discount to the
/// simulated supplier integration (audit log) and splits payment.
class FinalizeGroupPurchase {
  static GroupPurchaseEntity call(GroupPurchaseEntity purchase) {
    return GroupPurchaseEntity(
      id: purchase.id,
      organizerName: purchase.organizerName,
      itemName: purchase.itemName,
      itemDescription: purchase.itemDescription,
      unitPrice: purchase.unitPrice,
      minQuantityThreshold: purchase.minQuantityThreshold,
      dbStatus: GroupPurchaseStatus.finalized.index,
      deadline: purchase.deadline,
      createdAt: purchase.createdAt,
    );
  }
}
