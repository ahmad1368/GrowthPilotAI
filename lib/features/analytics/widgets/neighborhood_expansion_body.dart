import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_neighborhood_expansion_potential.dart';
import 'package:growth_pilot_ai/core/data/entities/neighborhood_expansion_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/neighborhood_expansion_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/neighborhood_expansion_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/neighborhood_expansion_view.dart';

/// Owns the logged-evaluation list (Issue #372), refreshing it locally
/// after each quick-add insert — mirrors [CompetitorProximityBody]'s
/// pattern.
class NeighborhoodExpansionBody extends StatefulWidget {
  final List<NeighborhoodExpansionEntity> initialEvaluations;

  const NeighborhoodExpansionBody({super.key, required this.initialEvaluations});

  @override
  State<NeighborhoodExpansionBody> createState() =>
      _NeighborhoodExpansionBodyState();
}

class _NeighborhoodExpansionBodyState extends State<NeighborhoodExpansionBody> {
  late List<NeighborhoodExpansionEntity> _evaluations =
      widget.initialEvaluations;

  Future<void> _addEvaluation() async {
    final evaluation = await showNeighborhoodExpansionDialog(context);
    if (evaluation == null) return;
    NeighborhoodExpansionRepository(
            Get.find<ObjectBox>().store.box<NeighborhoodExpansionEntity>())
        .insert(evaluation);
    setState(() => _evaluations = [..._evaluations, evaluation]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeNeighborhoodExpansionPotential.call(_evaluations);
    return NeighborhoodExpansionView(
        results: results, onAddEvaluation: _addEvaluation);
  }
}
