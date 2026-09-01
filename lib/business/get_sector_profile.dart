import 'package:growth_pilot_ai/business/sector_profiles.dart';
import 'package:growth_pilot_ai/core/models/sector_profile.dart';

/// Looks up a sector's [SectorProfile], falling back to `DEFAULT` for an
/// unrecognized category (Issue #104 AC: "Fallbacks").
class GetSectorProfile {
  static SectorProfile call(String sectorId) =>
      sectorProfiles[sectorId] ?? sectorProfiles['DEFAULT']!;
}
