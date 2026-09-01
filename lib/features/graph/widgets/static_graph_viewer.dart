import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:growth_pilot_ai/business/build_requirement_graph.dart';
import 'package:growth_pilot_ai/core/models/requirement_node.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_node_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Static Graph Rendering Engine" (Issue #219) — a hierarchical
/// flowchart via `graphview`'s BuchheimWalkerAlgorithm, pinch-to-zoom/
/// pan via [InteractiveViewer], and an "Auto-layout" toggle that
/// rebuilds the graph from the latest [nodes] (AC: "refresh the graph
/// structure when data changes").
class StaticGraphViewer extends StatefulWidget {
  final List<RequirementNode> nodes;

  const StaticGraphViewer({super.key, required this.nodes});

  @override
  State<StaticGraphViewer> createState() => _StaticGraphViewerState();
}

class _StaticGraphViewerState extends State<StaticGraphViewer> {
  late Graph? _graph = BuildRequirementGraph.call(widget.nodes);

  void _refresh() => setState(() => _graph = BuildRequirementGraph.call(widget.nodes));

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final graph = _graph;
    if (graph == null) {
      return Text('This requirement structure has a cycle and cannot be rendered.',
          style: TextStyle(color: colors.mutedForeground, fontSize: 12));
    }

    final labelsById = {for (final n in widget.nodes) n.id: n.label};
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(icon: const Icon(Icons.refresh), onPressed: _refresh),
        ),
        Expanded(
          child: InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(200),
            minScale: 0.2,
            maxScale: 3,
            child: GraphView(
              graph: graph,
              algorithm: BuchheimWalkerAlgorithm(
                  BuchheimWalkerConfiguration(), TreeEdgeRenderer(BuchheimWalkerConfiguration())),
              builder: (node) =>
                  RequirementNodeWidget(label: labelsById[node.key!.value] ?? '?'),
            ),
          ),
        ),
      ],
    );
  }
}
