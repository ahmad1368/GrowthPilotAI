import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/warranty_claim_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/warranty_claim_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/warranty_profitability_view.dart';

/// Owns the warranty-claim entry list (Issue #389), refreshing it locally
/// after each quick-add insert — mirrors [WasteLogBody]'s pattern.
class WarrantyProfitabilityBody extends StatefulWidget {
  final List<WarrantyClaimEntity> initialClaims;

  const WarrantyProfitabilityBody({super.key, required this.initialClaims});

  @override
  State<WarrantyProfitabilityBody> createState() =>
      _WarrantyProfitabilityBodyState();
}

class _WarrantyProfitabilityBodyState extends State<WarrantyProfitabilityBody> {
  late List<WarrantyClaimEntity> _claims = widget.initialClaims;

  Future<void> _addClaim() async {
    final claim = await showWarrantyClaimDialog(context);
    if (claim == null) return;
    WarrantyClaimRepository(Get.find<ObjectBox>().store.box<WarrantyClaimEntity>())
        .insert(claim);
    setState(() => _claims = [..._claims, claim]);
  }

  @override
  Widget build(BuildContext context) =>
      WarrantyProfitabilityView(claims: _claims, onAddClaim: _addClaim);
}
