import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

/// A merchant's self-service request for a promotional exposure package
/// (Issue #401) — this app has no ad-management backend, so requests
/// are logged locally and reviewed by an admin, the same
/// request/review workflow [CapExpansionRequestEntity] (#344) uses.
/// Once approved, an admin would separately schedule the actual
/// [AdCampaignEntity] (#366).
@Entity()
class AdvertisingRequestEntity {
  @Id()
  int id = 0;

  String merchantName;

  String category;

  int dbPackageType; // AdPackageType index

  int dbStatus; // AdRequestStatus index

  @Index()
  @Property(type: PropertyType.date)
  DateTime requestedAt;

  AdvertisingRequestEntity({
    this.id = 0,
    required this.merchantName,
    required this.category,
    required this.dbPackageType,
    this.dbStatus = 0, // AdRequestStatus.pending
    required this.requestedAt,
  });

  AdPackageType get packageType => AdPackageType.values[dbPackageType];
  set packageType(AdPackageType value) => dbPackageType = value.index;

  AdRequestStatus get status => AdRequestStatus.values[dbStatus];
  set status(AdRequestStatus value) => dbStatus = value.index;
}
