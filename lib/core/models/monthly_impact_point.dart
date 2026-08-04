/// One calendar month's average commission-adjustment impact (Issue
/// #349, acceptance criterion 2: "growth or decline percentages
/// categorized across temporal intervals").
class MonthlyImpactPoint {
  final String monthLabel;
  final double averageImpactPercent;
  final int changeCount;

  const MonthlyImpactPoint({
    required this.monthLabel,
    required this.averageImpactPercent,
    required this.changeCount,
  });
}
