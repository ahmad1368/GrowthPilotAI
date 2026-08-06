import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';
import 'package:growth_pilot_ai/core/enum/group_purchase_status.dart';

/// True once an open campaign's deadline has passed without being
/// finalized (Issue #414, acceptance criterion 1) — a derived read
/// rather than a persisted status, since nothing needs to happen on
/// expiry besides hiding the contribution form.
class IsGroupPurchaseExpired {
  static bool call(GroupPurchaseEntity purchase, DateTime now) {
    return purchase.status == GroupPurchaseStatus.open && now.isAfter(purchase.deadline);
  }
}
