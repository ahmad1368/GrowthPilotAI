/// Flags a product as low-stock (Issue #143, "Stock Triggers") — a
/// fixed app-wide threshold since there's no per-listing configurable
/// value in the current entity model.
class IsLowStock {
  static const threshold = 5;
  static bool call(int stockLevel) => stockLevel <= threshold;
}
