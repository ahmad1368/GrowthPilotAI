import '../../../../objectbox.g.dart';
import '../entities/subscription_entity.dart';

/// Thin ObjectBox wrapper for billing tiers (Issue #150) — one row per
/// business, upserted in place.
class SubscriptionRepository {
  final Box<SubscriptionEntity> _box;

  SubscriptionRepository(this._box);

  SubscriptionEntity? getForBusiness(String businessId) {
    final query = _box.query(SubscriptionEntity_.businessId.equals(businessId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  int upsert(SubscriptionEntity subscription) => _box.put(subscription);
}
