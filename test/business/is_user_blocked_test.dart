import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_user_blocked.dart';
import 'package:growth_pilot_ai/core/data/entities/block_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('is blocked regardless of which side initiated the block', () {
    final blocks = [BlockEntity(blockerId: 'a', blockedId: 'b', createdAt: now)];
    expect(IsUserBlocked.call(blocks, 'a', 'b'), isTrue);
    expect(IsUserBlocked.call(blocks, 'b', 'a'), isTrue);
  });

  test('is not blocked when no relevant block exists', () {
    final blocks = [BlockEntity(blockerId: 'a', blockedId: 'c', createdAt: now)];
    expect(IsUserBlocked.call(blocks, 'a', 'b'), isFalse);
  });
}
