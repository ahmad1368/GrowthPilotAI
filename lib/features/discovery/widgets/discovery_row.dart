import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/search_catalog_listings.dart';

/// One discovery search result row (Issue #121).
class DiscoveryRow extends StatelessWidget {
  final ScoredListing result;
  const DiscoveryRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final distance = result.distanceKm;
    final distanceText = distance == null ? '' : ' — ${distance.toStringAsFixed(1)}km away';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '${result.listing.title} — ${result.listing.category} — '
        '${(result.score * 100).round()}% match$distanceText',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
