import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_csat_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/csat_rating_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/csat_rating_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/csat_summary_view.dart';

/// Owns the logged-rating list (Issue #375), refreshing it locally after
/// each quick-add insert — mirrors [DiscountCampaignImpactBody]'s pattern.
class CsatSummaryBody extends StatefulWidget {
  final List<CsatRatingEntity> initialRatings;

  const CsatSummaryBody({super.key, required this.initialRatings});

  @override
  State<CsatSummaryBody> createState() => _CsatSummaryBodyState();
}

class _CsatSummaryBodyState extends State<CsatSummaryBody> {
  late List<CsatRatingEntity> _ratings = widget.initialRatings;

  Future<void> _addRating() async {
    final rating = await showCsatRatingDialog(context);
    if (rating == null) return;
    CsatRatingRepository(Get.find<ObjectBox>().store.box<CsatRatingEntity>())
        .insert(rating);
    setState(() => _ratings = [..._ratings, rating]);
  }

  @override
  Widget build(BuildContext context) {
    final summary = ComputeCsatSummary.call(_ratings);
    return CsatSummaryView(
        summary: summary, ratings: _ratings, onAddRating: _addRating);
  }
}
