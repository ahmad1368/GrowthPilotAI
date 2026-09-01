import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_traffic_steering_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/traffic_steering_directive_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/traffic_steering_directive_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_steering_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_steering_view.dart';

/// Owns the logged-directive list (Issue #334), refreshing it locally
/// after each quick-add insert — mirrors [MerchantBranchBody]'s pattern.
class TrafficSteeringBody extends StatefulWidget {
  final List<TrafficSteeringDirectiveEntity> initialDirectives;

  const TrafficSteeringBody({super.key, required this.initialDirectives});

  @override
  State<TrafficSteeringBody> createState() => _TrafficSteeringBodyState();
}

class _TrafficSteeringBodyState extends State<TrafficSteeringBody> {
  late List<TrafficSteeringDirectiveEntity> _directives =
      widget.initialDirectives;

  Future<void> _addDirective() async {
    final directive = await showTrafficSteeringDialog(context);
    if (directive == null) return;
    TrafficSteeringDirectiveRepository(Get.find<ObjectBox>()
            .store
            .box<TrafficSteeringDirectiveEntity>())
        .insert(directive);
    setState(() => _directives = [..._directives, directive]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeTrafficSteeringSummary.call(_directives);
    return TrafficSteeringView(results: results, onAddDirective: _addDirective);
  }
}
