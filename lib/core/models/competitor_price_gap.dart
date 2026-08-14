/// One logged competitor price observation's gap read (Issue #351): how
/// our price compares to the observed competitor price.
class CompetitorPriceGap {
  final String productName;
  final String competitorName;
  final double ourPrice;
  final double competitorPrice;
  final double priceGap;
  final double gapPercent;
  final bool isPricedAboveCompetitor;

  const CompetitorPriceGap({
    required this.productName,
    required this.competitorName,
    required this.ourPrice,
    required this.competitorPrice,
    required this.priceGap,
    required this.gapPercent,
    required this.isPricedAboveCompetitor,
  });
}
