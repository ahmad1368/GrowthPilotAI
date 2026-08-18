import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

/// "Orphan processes that aren't connected to the main goal" (Issue
/// #223, section 1): nodes with zero incoming AND zero outgoing edges —
/// completely isolated from the rest of the process.
class FindOrphanNodes {
  static List<ProcessNode> call(ProcessGraph graph) {
    return graph.nodes
        .where((n) => graph.inDegree(n.id) == 0 && graph.outDegree(n.id) == 0)
        .toList();
  }
}
