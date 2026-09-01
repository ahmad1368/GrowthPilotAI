import 'package:growth_pilot_ai/core/data/entities/block_entity.dart';

/// "Instant Severance" (Issue #124 AC) — bidirectional: either party
/// having blocked the other is enough to sever the connection.
class IsUserBlocked {
  static bool call(List<BlockEntity> blocks, String userA, String userB) {
    return blocks.any((b) =>
        (b.blockerId == userA && b.blockedId == userB) ||
        (b.blockerId == userB && b.blockedId == userA));
  }
}
