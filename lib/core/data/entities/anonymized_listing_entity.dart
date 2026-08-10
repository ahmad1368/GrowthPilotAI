import 'package:objectbox/objectbox.dart';

/// One "Shadow Record" (Issue #93) in the decoupled analytics store — a
/// separate ObjectBox box from any raw/production entity, so this app's
/// analog of "a MongoDB instance the production DB never touches" is a
/// physically distinct box holding only already-hashed/generalized
/// fields. Never written to directly from raw data; only via
/// [SyncToAnalyticsStore].
@Entity()
class AnonymizedListingEntity {
  @Id()
  int id = 0;

  @Index()
  String hashedId;

  double generalizedLat;
  double generalizedLng;
  String category;
  String generalAge;

  @Property(type: PropertyType.date)
  DateTime recordedAt;

  /// TTL for this shadow record (Issue #94 AC: "verifiable expireAt
  /// timestamp") — this app has no MongoDB TTL index, so expiry is
  /// enforced by [PurgeExpiredAnalyticsRecords] instead of the database.
  @Index()
  @Property(type: PropertyType.date)
  DateTime expireAt;

  AnonymizedListingEntity({
    this.id = 0,
    required this.hashedId,
    required this.generalizedLat,
    required this.generalizedLng,
    required this.category,
    required this.generalAge,
    required this.recordedAt,
    required this.expireAt,
  });
}
