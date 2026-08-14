import 'package:growth_pilot_ai/core/models/sector_profile.dart';

/// "Intelligence Profiles" for key BC market sectors (Issue #104 scope
/// item 1), mirroring the issue's own `SECTOR_PROFILES` constant — new
/// sectors are added here without touching [GetSectorProfile]'s logic
/// (AC: "Extensibility"). `DEFAULT` backs the "Fallbacks" AC.
const sectorProfiles = <String, SectorProfile>{
  'AUTOMOTIVE': SectorProfile(
    sectorId: 'AUTOMOTIVE',
    primaryMetrics: ['mileageEfficiency', 'maintenanceHistory', 'localAvailability'],
    radarAxisLabels: ['Mileage', 'History', 'Price', 'Reliability', 'Safety'],
    axisWeights: {'Mileage': 3.0},
  ),
  'ELECTRONICS': SectorProfile(
    sectorId: 'ELECTRONICS',
    primaryMetrics: ['depreciation', 'marketDemand', 'priceValue'],
    radarAxisLabels: ['Warranty', 'Battery', 'Value', 'Condition', 'Demand'],
  ),
  'HOME_GOODS': SectorProfile(
    sectorId: 'HOME_GOODS',
    primaryMetrics: ['durability', 'styleMatch', 'priceValue'],
    radarAxisLabels: ['Durability', 'Style', 'Value', 'Condition', 'Demand'],
  ),
  'SERVICES': SectorProfile(
    sectorId: 'SERVICES',
    primaryMetrics: ['providerRating', 'responseTime', 'priceValue'],
    radarAxisLabels: ['Rating', 'Speed', 'Value', 'Availability', 'Trust'],
  ),
  'DEFAULT': SectorProfile(
    sectorId: 'DEFAULT',
    primaryMetrics: ['priceValue'],
    radarAxisLabels: ['Price', 'Distance', 'Condition', 'Demand', 'Trust'],
  ),
};
