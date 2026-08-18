import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/positioned_process_node.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';

/// The full result of generating a diagram from text (Issue #224) — the
/// graph, its auto-computed layout, and an immediate bottleneck check
/// (AC: "the Analysis Engine immediately runs a check to provide
/// instant feedback on the user's text description").
@immutable
class GeneratedDiagram {
  final ProcessGraph graph;
  final List<PositionedProcessNode> positions;
  final List<BottleneckInsight> insights;

  const GeneratedDiagram({required this.graph, required this.positions, required this.insights});
}
