import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/build_catalog_grid_cards.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One catalog listing's card in the grid (Issue #142). Flat
/// [ShadCard], not the issue's literal Glassmorphism ask — this
/// project's architecture explicitly forbids Glassmorphism/
/// BackdropFilter (see #1/#118's [DashboardTemplateCard] precedent).
class CatalogGridCard extends StatelessWidget {
  final CatalogCard card;
  const CatalogGridCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(8),
      title: Text(card.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      description: Text('${card.category} — ${card.priceDisplay}', style: const TextStyle(fontSize: 12)),
      child: card.thumbnail == null
          ? const SizedBox(height: 80, child: Center(child: Icon(Icons.image_outlined)))
          : Image.memory(card.thumbnail!, height: 80, fit: BoxFit.cover),
    );
  }
}
