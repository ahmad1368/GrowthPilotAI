import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_service_restriction_statuses.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/service_restriction_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/service_restriction_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/service_restriction_view.dart';

/// Owns the logged restriction list (Issue #337), refreshing it locally
/// after each quick-add insert — mirrors [PromotionalOfferBody]'s
/// pattern.
class ServiceRestrictionBody extends StatefulWidget {
  final List<ServiceRestrictionEntity> initialRestrictions;

  const ServiceRestrictionBody({super.key, required this.initialRestrictions});

  @override
  State<ServiceRestrictionBody> createState() =>
      _ServiceRestrictionBodyState();
}

class _ServiceRestrictionBodyState extends State<ServiceRestrictionBody> {
  late List<ServiceRestrictionEntity> _restrictions =
      widget.initialRestrictions;

  Future<void> _addRestriction() async {
    final restriction = await showServiceRestrictionDialog(context);
    if (restriction == null) return;
    ServiceRestrictionRepository(
            Get.find<ObjectBox>().store.box<ServiceRestrictionEntity>())
        .insert(restriction);
    setState(() => _restrictions = [..._restrictions, restriction]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeServiceRestrictionStatuses.call(_restrictions);
    return ServiceRestrictionView(
        results: results, onAddRestriction: _addRestriction);
  }
}
