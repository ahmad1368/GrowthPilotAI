import 'package:growth_pilot_ai/business/get_sector_profile.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';
import 'package:growth_pilot_ai/core/models/intelligence_bundle.dart';

/// Assembles the sector-scoped [IntelligenceBundle] (Issue #104 scope item
/// 2: "Dynamic Payload Construction") by pairing #103's [DistilledContext]
/// with the sector's [GetSectorProfile] lookup — the bundle's only two
/// inputs, so cross-sector leakage (AC: "Privacy Integrity") is
/// structurally impossible.
class BuildIntelligenceBundle {
  static IntelligenceBundle call(String sectorId, DistilledContext context) {
    final profile = GetSectorProfile.call(sectorId);

    return IntelligenceBundle(
      sector: profile.sectorId,
      radarAxisLabels: profile.radarAxisLabels,
      context: context,
      highlights: _extractHighlights(context),
    );
  }

  /// Top "Wins/Warnings" for this one context, mirroring the issue's own
  /// `extractHighlights` cap of 3.
  static List<String> _extractHighlights(DistilledContext context) {
    final highlights = <String>[];

    if (context.isHiddenGem) {
      highlights.add('Hidden gem: priced well below market and close by.');
    }
    if (context.marketTemperature == MarketTemperature.hot) {
      highlights.add('High demand: this sector is moving fast right now.');
    }
    final pricePosition = context.pricePosition;
    if (pricePosition != null && pricePosition <= 0.2) {
      highlights.add('Priced in the bottom 20% for this sector.');
    }
    if (pricePosition != null && pricePosition >= 0.8) {
      highlights.add('Priced in the top 20% for this sector.');
    }
    if (context.scarcityIndex >= 0.5) {
      highlights.add('Low availability: few comparable listings in this sector.');
    }

    return highlights.take(3).toList();
  }
}
