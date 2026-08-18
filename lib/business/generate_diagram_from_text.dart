import 'package:growth_pilot_ai/business/build_bottleneck_insights.dart';
import 'package:growth_pilot_ai/business/compute_layered_layout.dart';
import 'package:growth_pilot_ai/business/parse_text_to_process_graph.dart';
import 'package:growth_pilot_ai/core/models/generated_diagram.dart';

/// The "Diagram Generation Engine" entry point (Issue #224): text in,
/// a laid-out, analyzed [GeneratedDiagram] out — combining
/// [ParseTextToProcessGraph], [ComputeLayeredLayout], and #223's
/// [BuildBottleneckInsights] into one local pipeline.
class GenerateDiagramFromText {
  static GeneratedDiagram call(String text) {
    final graph = ParseTextToProcessGraph.call(text);
    return GeneratedDiagram(
      graph: graph,
      positions: ComputeLayeredLayout.call(graph),
      insights: BuildBottleneckInsights.call(graph),
    );
  }
}
