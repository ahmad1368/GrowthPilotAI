import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

/// "Dead-end Detection" (Issue #223, section 1): nodes with at least one
/// incoming edge but zero outgoing edges — a step reached from the
/// process but with no path forward. Distinguishing an intentional End
/// Event from an accidental dead end needs node-type metadata (#222's
/// BPMN node types) that doesn't exist yet — every zero-outdegree node
/// reached by an edge is flagged here (see PR notes).
class FindDeadEndNodes {
  static List<ProcessNode> call(ProcessGraph graph) {
    return graph.nodes
        .where((n) => graph.inDegree(n.id) > 0 && graph.outDegree(n.id) == 0)
        .toList();
  }
}
