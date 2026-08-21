/// "The 101st user does NOT receive the free trial automatically"
/// (Issue #191 AC) — a pure capacity check.
class ShouldGrantFoundingMemberSpot {
  static bool call({required int claimedCount, required int capacity}) => claimedCount < capacity;
}
