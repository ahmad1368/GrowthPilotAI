import '../../../../objectbox.g.dart';
import '../entities/business_rating_entity.dart';

/// Thin ObjectBox wrapper for business ratings (Issue #125).
class BusinessRatingRepository {
  final Box<BusinessRatingEntity> _box;

  BusinessRatingRepository(this._box);

  List<BusinessRatingEntity> getAll() => _box.getAll();

  List<BusinessRatingEntity> getForBusiness(String businessId) =>
      _box.getAll().where((r) => r.businessId == businessId).toList();

  int insert(BusinessRatingEntity rating) => _box.put(rating);
}
