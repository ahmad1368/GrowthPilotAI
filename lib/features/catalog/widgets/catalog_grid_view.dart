import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_catalog_grid_cards.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_grid_card.dart';

/// Renders the catalog listings as a responsive grid of flat cards
/// (Issue #142). Purely presentational.
class CatalogGridView extends StatelessWidget {
  final List<CatalogCard> cards;
  const CatalogGridView({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return const Text('No listings yet.', style: TextStyle(fontSize: 12));
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, childAspectRatio: 1.1),
      itemCount: cards.length,
      itemBuilder: (context, i) => CatalogGridCard(card: cards[i]),
    );
  }
}
