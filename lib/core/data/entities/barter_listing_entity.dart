import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/barter_listing_status.dart';

/// A surplus item/service a merchant offers for peer-to-peer barter
/// (Issue #413) — this app has no marketplace/escrow/geolocation
/// backend, so escrow is a status flag and proximity is a text zone.
@Entity()
class BarterListingEntity {
  @Id()
  int id = 0;

  String merchantName;
  String surplusItemName;
  String surplusItemDescription;
  String wantedItemName;
  String category;
  double estimatedValue;
  String geoZone;
  int dbStatus; // BarterListingStatus index

  @Property(type: PropertyType.date)
  DateTime listedAt;

  BarterListingEntity({
    this.id = 0,
    required this.merchantName,
    required this.surplusItemName,
    required this.surplusItemDescription,
    required this.wantedItemName,
    required this.category,
    required this.estimatedValue,
    required this.geoZone,
    this.dbStatus = 0, // BarterListingStatus.active
    required this.listedAt,
  });

  BarterListingStatus get status => BarterListingStatus.values[dbStatus];
  set status(BarterListingStatus value) => dbStatus = value.index;
}
