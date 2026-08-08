import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/find_nearby_listings.dart';
import 'package:growth_pilot_ai/core/data/entities/user_location_preference_entity.dart';
import 'package:growth_pilot_ai/features/geo/widgets/geo_location_row.dart';
import 'package:growth_pilot_ai/features/geo/widgets/geo_location_search_input.dart';

/// Renders the location setter plus the nearby-listings list (Issue
/// #213). Purely presentational.
class GeoLocationView extends StatelessWidget {
  final UserLocationPreferenceEntity? location;
  final List<NearbyListing> nearby;
  final String? error;
  final void Function(String) onSetLocation;

  const GeoLocationView({
    super.key,
    required this.location,
    required this.nearby,
    required this.error,
    required this.onSetLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GeoLocationSearchInput(onSetLocation: onSetLocation),
      if (error != null)
        Text(error!, style: const TextStyle(fontSize: 12, color: Colors.red)),
      if (location != null)
        Text('My Location: ${location!.postalCode} (${location!.lat.toStringAsFixed(4)}, '
            '${location!.lng.toStringAsFixed(4)})', style: const TextStyle(fontSize: 12)),
      const SizedBox(height: 4),
      if (nearby.isEmpty)
        const Text('No nearby listings yet.', style: TextStyle(fontSize: 12))
      else
        for (final entry in nearby) GeoLocationRow(entry: entry),
    ]);
  }
}
