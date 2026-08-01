import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_merchant_partnership_value.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_partnership_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_partnership_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_partnership_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_partnership_view.dart';

/// Owns the logged-partnership list (Issue #393), refreshing it locally
/// after each quick-add insert — mirrors [NeighborhoodExpansionBody]'s
/// pattern.
class MerchantPartnershipBody extends StatefulWidget {
  final List<MerchantPartnershipEntity> initialPartnerships;

  const MerchantPartnershipBody({super.key, required this.initialPartnerships});

  @override
  State<MerchantPartnershipBody> createState() =>
      _MerchantPartnershipBodyState();
}

class _MerchantPartnershipBodyState extends State<MerchantPartnershipBody> {
  late List<MerchantPartnershipEntity> _partnerships =
      widget.initialPartnerships;

  Future<void> _addPartnership() async {
    final partnership = await showMerchantPartnershipDialog(context);
    if (partnership == null) return;
    MerchantPartnershipRepository(
            Get.find<ObjectBox>().store.box<MerchantPartnershipEntity>())
        .insert(partnership);
    setState(() => _partnerships = [..._partnerships, partnership]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeMerchantPartnershipValue.call(_partnerships);
    return MerchantPartnershipView(
        results: results, onAddPartnership: _addPartnership);
  }
}
