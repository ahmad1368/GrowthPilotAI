import '../../../../objectbox.g.dart';
import '../entities/founding_member_counter_entity.dart';
import '../entities/founding_member_entity.dart';

/// ObjectBox wrapper for the Founding Member program (Issue #191) —
/// [_counterBox] holds a single global counter row, [_memberBox] one
/// row per business that has claimed a spot.
class FoundingMemberRepository {
  final Box<FoundingMemberCounterEntity> _counterBox;
  final Box<FoundingMemberEntity> _memberBox;

  FoundingMemberRepository(this._counterBox, this._memberBox);

  FoundingMemberCounterEntity getCounter() {
    final all = _counterBox.getAll();
    if (all.isNotEmpty) return all.first;
    final fresh = FoundingMemberCounterEntity();
    fresh.id = _counterBox.put(fresh);
    return fresh;
  }

  void incrementCounter() {
    final counter = getCounter();
    counter.claimedCount += 1;
    _counterBox.put(counter);
  }

  FoundingMemberEntity? getForBusiness(String businessId) {
    final query = _memberBox.query(FoundingMemberEntity_.businessId.equals(businessId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  void saveMember(FoundingMemberEntity member) => _memberBox.put(member);
}
