import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';

/// The "Strategic Vector" [DistillMarketContext] reduces a peer group
/// into (Issue #103) — every field is a derived score/flag, never a raw
/// competitor price or id (AC: "Privacy Guard"). [pricePosition] is null
/// when the peer group was too small for #96 to rank against.
@immutable
class DistilledContext {
  final MarketTemperature marketTemperature;
  final double? pricePosition;
  final double scarcityIndex;
  final bool isHiddenGem;

  const DistilledContext({
    required this.marketTemperature,
    required this.pricePosition,
    required this.scarcityIndex,
    required this.isHiddenGem,
  });
}
