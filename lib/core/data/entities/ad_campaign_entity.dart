import 'package:objectbox/objectbox.dart';

/// Promotional channel for one advertising campaign (Issue #366).
enum AdChannel { digital, print, local }

/// A logged historical advertising campaign (Issue #366) — this app has
/// no marketing/ad-spend backend, so campaigns are recorded manually
/// here, the same lightweight logging pattern [WasteLogEntity] uses.
@Entity()
class AdCampaignEntity {
  @Id()
  int id = 0;

  String name;

  double cost;

  int dbChannel;

  @Index()
  @Property(type: PropertyType.date)
  DateTime startDate;

  @Property(type: PropertyType.date)
  DateTime endDate;

  AdCampaignEntity({
    this.id = 0,
    required this.name,
    required this.cost,
    required this.startDate,
    required this.endDate,
    this.dbChannel = 0,
  });

  AdChannel get channel => AdChannel.values[dbChannel];
  set channel(AdChannel value) => dbChannel = value.index;
}
