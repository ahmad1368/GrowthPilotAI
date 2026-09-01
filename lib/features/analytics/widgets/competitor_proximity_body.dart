import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_competitor_proximity_impacts.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/competitor_sighting_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_proximity_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_proximity_view.dart';

/// Owns the logged-sighting list (Issue #374), refreshing it locally
/// after each quick-add insert — mirrors [CompetitorPriceBody]'s pattern.
class CompetitorProximityBody extends StatefulWidget {
  final List<CompetitorSightingEntity> initialSightings;

  const CompetitorProximityBody({super.key, required this.initialSightings});

  @override
  State<CompetitorProximityBody> createState() =>
      _CompetitorProximityBodyState();
}

class _CompetitorProximityBodyState extends State<CompetitorProximityBody> {
  late List<CompetitorSightingEntity> _sightings = widget.initialSightings;

  Future<void> _addSighting() async {
    final sighting = await showCompetitorProximityDialog(context);
    if (sighting == null) return;
    CompetitorSightingRepository(
            Get.find<ObjectBox>().store.box<CompetitorSightingEntity>())
        .insert(sighting);
    setState(() => _sightings = [..._sightings, sighting]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeCompetitorProximityImpacts.call(_sightings);
    return CompetitorProximityView(results: results, onAddSighting: _addSighting);
  }
}
