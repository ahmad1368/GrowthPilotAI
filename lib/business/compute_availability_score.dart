import 'package:growth_pilot_ai/core/enum/catalog_availability.dart';

/// "Capacity/Availability" input (Issue #145 AC: "Is the provider
/// currently Available?").
class ComputeAvailabilityScore {
  static double call(CatalogAvailability availability) =>
      availability == CatalogAvailability.available ? 1.0 : 0.0;
}
