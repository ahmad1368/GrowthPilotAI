/// "Queries on very small datasets (n < 5) are automatically blocked or
/// suppressed" (Issue #81 AC) — below [minimumSize], a Laplace-noised
/// result would still let a single outlier dominate the aggregate, so
/// the query is refused entirely rather than noised.
class IsDatasetTooSmallForDp {
  static bool call(int datasetSize, {int minimumSize = 5}) => datasetSize < minimumSize;
}
