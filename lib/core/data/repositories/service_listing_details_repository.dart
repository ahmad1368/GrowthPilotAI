import '../../../../objectbox.g.dart';
import '../entities/service_listing_details_entity.dart';

/// Insert/lookup CRUD for the Service discriminator's fields (Issue
/// #138, acceptance criterion 2).
class ServiceListingDetailsRepository {
  final Box<ServiceListingDetailsEntity> _box;

  ServiceListingDetailsRepository(this._box);

  int save(ServiceListingDetailsEntity details) => _box.put(details);

  ServiceListingDetailsEntity? forListing(int listingId) =>
      _box.getAll().where((d) => d.listingId == listingId).firstOrNull;
}
