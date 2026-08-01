import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_promotional_offer_performance.dart';
import 'package:growth_pilot_ai/core/data/entities/promotional_offer_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/promotional_offer_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promotional_offer_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/promotional_offer_view.dart';

/// Owns the logged-offer list (Issue #335), refreshing it locally after
/// each quick-add insert — mirrors [TrafficSteeringBody]'s pattern.
class PromotionalOfferBody extends StatefulWidget {
  final List<PromotionalOfferEntity> initialOffers;

  const PromotionalOfferBody({super.key, required this.initialOffers});

  @override
  State<PromotionalOfferBody> createState() => _PromotionalOfferBodyState();
}

class _PromotionalOfferBodyState extends State<PromotionalOfferBody> {
  late List<PromotionalOfferEntity> _offers = widget.initialOffers;

  Future<void> _addOffer() async {
    final offer = await showPromotionalOfferDialog(context);
    if (offer == null) return;
    PromotionalOfferRepository(
            Get.find<ObjectBox>().store.box<PromotionalOfferEntity>())
        .insert(offer);
    setState(() => _offers = [..._offers, offer]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputePromotionalOfferPerformance.call(_offers);
    return PromotionalOfferView(results: results, onAddOffer: _addOffer);
  }
}
