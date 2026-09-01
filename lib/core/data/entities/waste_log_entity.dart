import 'package:objectbox/objectbox.dart';

/// Categorical reason for a discarded item (Issue #377).
enum WasteReason { expiration, damage, overPreparation, other }

@Entity()
class WasteLogEntity {
  @Id()
  int id = 0;

  String itemDescription;

  double estimatedValue;

  @Index()
  DateTime date;

  // Stored as an int in ObjectBox, same pattern as TransactionEntity.dbType.
  int dbReason;

  WasteLogEntity({
    this.id = 0,
    required this.itemDescription,
    required this.estimatedValue,
    required this.date,
    this.dbReason = 0,
  });

  WasteReason get reason => WasteReason.values[dbReason];
  set reason(WasteReason value) => dbReason = value.index;
}
