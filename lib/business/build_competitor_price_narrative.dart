import 'package:growth_pilot_ai/core/models/competitor_price_gap.dart';

/// One-sentence read naming the biggest logged price risk and advantage
/// against competitors (Issue #351).
class BuildCompetitorPriceNarrative {
  static String call(List<CompetitorPriceGap> results) {
    if (results.isEmpty) {
      return 'No competitor prices logged yet — add one to start tracking price gaps.';
    }
    if (results.length == 1) {
      final only = results.first;
      return only.isPricedAboveCompetitor
          ? '${only.productName} is priced above ${only.competitorName}.'
          : '${only.productName} is priced below ${only.competitorName}.';
    }
    final worst = results.first;
    final best = results.last;
    return '${worst.productName} is your biggest price risk vs ${worst.competitorName} — '
        '${best.productName} beats ${best.competitorName} by comparison.';
  }
}
