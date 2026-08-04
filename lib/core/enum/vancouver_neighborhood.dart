/// Predefined Vancouver neighborhoods an emergency broadcast can target
/// (Issue #345, acceptance criterion 1) — this app has no map/geofencing
/// SDK, so zone selection is a fixed list rather than a drawn boundary.
enum VancouverNeighborhood {
  downtown,
  gastown,
  westEnd,
  kitsilano,
  mountPleasant,
  eastVancouver,
  richmond,
  burnaby,
}
