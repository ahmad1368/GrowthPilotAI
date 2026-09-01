/// Local stand-in for the issue's `help_terms.json`/CMS collection
/// (Issue #164) — plain-English definitions for financial/technical
/// terms, keyed by `termKey`. Centralized here so definitions can be
/// updated in one place without touching the widgets that show them.
class HelpTermsCatalog {
  static const Map<String, String> definitions = {
    'efficiency_score':
        'How well your listing prices compare to similar businesses nearby — higher means you\'re more competitive.',
    'market_comparison':
        'How your business measures up against others in your sector across several factors, like pricing and response time.',
    'landed_cost':
        'The total price of a product once it has arrived at your door, including shipping and provincial taxes.',
    'normalized_unit_price':
        'The price per standard unit (e.g. per kg or per liter), adjusted so items sold in different sizes can be compared fairly.',
    'tax_recovery_projection':
        'An estimate of how much tax you may be able to claim back based on your recorded expenses.',
    'supply_chain_variance':
        'How much your delivery times and costs from suppliers fluctuate from one order to the next.',
  };
}
