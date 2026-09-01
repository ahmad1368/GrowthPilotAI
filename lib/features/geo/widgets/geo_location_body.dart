import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/find_nearby_listings.dart';
import 'package:growth_pilot_ai/features/geo/widgets/geo_location_actions.dart';
import 'package:growth_pilot_ai/features/geo/widgets/geo_location_repos.dart';
import 'package:growth_pilot_ai/features/geo/widgets/geo_location_view.dart';

/// Owns the geo-location demo state (Issue #213) — no real map/geocoding
/// API is available offline, so this renders a distance-sorted list of
/// catalog listings in place of an interactive map.
class GeoLocationBody extends StatefulWidget {
  const GeoLocationBody({super.key});
  @override
  State<GeoLocationBody> createState() => _GeoLocationBodyState();
}

class _GeoLocationBodyState extends State<GeoLocationBody> {
  static const _radiusKm = 50.0;

  final _actions = GeoLocationActions(GeoLocationRepos());
  String? _error;
  late List<NearbyListing> _nearby = _actions.loadNearby(_radiusKm);

  void _setLocation(String postalCode) {
    final result = _actions.setPostalCode(postalCode);
    setState(() {
      _error = result == null ? 'Unrecognized postal code prefix.' : null;
      _nearby = _actions.loadNearby(_radiusKm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GeoLocationView(
      location: _actions.currentLocation,
      nearby: _nearby,
      error: _error,
      onSetLocation: _setLocation,
    );
  }
}
