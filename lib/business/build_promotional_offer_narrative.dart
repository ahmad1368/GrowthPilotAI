import 'package:growth_pilot_ai/core/models/promotional_offer_performance.dart';

/// One-sentence read naming the best-performing dispatched offer (Issue
/// #335).
class BuildPromotionalOfferNarrative {
  static String call(List<PromotionalOfferPerformance> results) {
    if (results.isEmpty) {
      return 'No offers dispatched yet — add one to start tracking engagement.';
    }
    final top = results.first;
    return '"${top.offerText}" targeting ${top.targetFilter} leads with a '
        '${top.usageRatePercent.toStringAsFixed(1)}% usage rate '
        '(${top.openRatePercent.toStringAsFixed(1)}% opened).';
  }
}
