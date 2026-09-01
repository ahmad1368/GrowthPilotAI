import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/find_nearby_listings.dart';

/// One nearby-listing row showing title and distance (Issue #213).
class GeoLocationRow extends StatelessWidget {
  final NearbyListing entry;
  const GeoLocationRow({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '${entry.listing.title} — ${entry.listing.industry} — '
        '${entry.distanceKm.toStringAsFixed(1)}km away',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
