/// "Gap Calculation Logic" (Issue #100 scope item 1): a balanced score
/// between an item's price-percentile rank (#96) and its proximity —
/// mirrors the issue's own `calculateEfficiencyGap`. Both inputs and
/// the output are 0-100 relative rankings, never raw peer data (AC:
/// "Privacy Check ... only relative ranking is displayed", #90).
class ComputeEfficiencyGap {
  static int call(int itemPercentile, int distancePercentile) {
    final score = (itemPercentile + (100 - distancePercentile)) / 2;
    return score.round();
  }
}
