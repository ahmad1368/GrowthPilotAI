import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';
import 'package:growth_pilot_ai/core/models/catalog_listing_summary.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_listing_form.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_listing_row.dart';

/// Renders the creation form, any validation errors, and the listing
/// grid (Issue #138). Purely presentational.
class CatalogView extends StatelessWidget {
  final List<CatalogListingSummary> summaries;
  final List<String> errors;
  final void Function(
      {required String title,
      required String industry,
      required String category,
      required CatalogListingType type,
      required double price}) onCreate;

  const CatalogView({
    super.key,
    required this.summaries,
    required this.errors,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CatalogListingForm(onCreate: onCreate),
      for (final error in errors)
        Text(error, style: const TextStyle(fontSize: 11, color: Colors.red)),
      const SizedBox(height: 8),
      if (summaries.isEmpty)
        const Text('No listings yet.', style: TextStyle(fontSize: 12))
      else
        for (final summary in summaries) CatalogListingRow(summary: summary),
    ]);
  }
}
