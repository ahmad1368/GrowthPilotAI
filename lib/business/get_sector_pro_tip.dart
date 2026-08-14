import 'package:growth_pilot_ai/business/sector_pro_tips.dart';

/// Looks up a sector's "Pro Tip", falling back to `DEFAULT` for an
/// unrecognized category (Issue #104 AC: "Fallbacks"), mirroring
/// [GetSectorProfile]'s lookup shape.
class GetSectorProTip {
  static String call(String sectorId) => sectorProTips[sectorId] ?? sectorProTips['DEFAULT']!;
}
