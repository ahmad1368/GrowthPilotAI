import 'package:objectbox/objectbox.dart';

/// One block relationship (Issue #124/#134) — the local equivalent of
/// the MongoDB `BlockList` collection. Severance is bidirectional: either
/// party having blocked the other is enough to sever the connection.
@Entity()
class BlockEntity {
  @Id()
  int id = 0;

  @Index()
  String blockerId;

  @Index()
  String blockedId;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  BlockEntity({
    this.id = 0,
    required this.blockerId,
    required this.blockedId,
    required this.createdAt,
  });
}
