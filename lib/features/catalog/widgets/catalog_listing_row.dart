import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/catalog_listing_summary.dart';

/// One catalog listing's display row (Issue #138) — shows the
/// discriminator-resolved price and the distance-from-Surrey the
/// geospatial acceptance criterion is tested against.
class CatalogListingRow extends StatelessWidget {
  final CatalogListingSummary summary;
  const CatalogListingRow({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l = summary.listing;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        '${l.title} (${l.listingType.name}) — ${l.industry}/${l.category} — '
        '${summary.priceDisplay} — ${summary.distanceFromSurreyKm.toStringAsFixed(1)}km from Surrey',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
