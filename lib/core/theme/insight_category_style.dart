import 'package:flutter/material.dart';

/// [Issue #837] Icon + accent color for an insight card, keyed by
/// [InsightModel.category] — replaces the single generic icon every
/// card used to share regardless of content.
class InsightCategoryVisual {
  final IconData icon;
  final Color color;
  const InsightCategoryVisual(this.icon, this.color);
}

class InsightCategoryStyle {
  static const _styles = <String, InsightCategoryVisual>{
    'Revenue': InsightCategoryVisual(Icons.trending_up_rounded, Color(0xFF22C55E)),
    'Cost Control': InsightCategoryVisual(Icons.savings_rounded, Color(0xFFF97316)),
    'Customer': InsightCategoryVisual(Icons.people_rounded, Color(0xFF3B82F6)),
    'Inventory': InsightCategoryVisual(Icons.inventory_2_rounded, Color(0xFFA855F7)),
    'Marketing': InsightCategoryVisual(Icons.campaign_rounded, Color(0xFFEC4899)),
  };

  static const _fallback = InsightCategoryVisual(Icons.auto_graph_rounded, Color(0xFF64748B));

  static const orderedCategories = ['Revenue', 'Cost Control', 'Customer', 'Inventory', 'Marketing'];

  static InsightCategoryVisual forCategory(String category) => _styles[category] ?? _fallback;
}
