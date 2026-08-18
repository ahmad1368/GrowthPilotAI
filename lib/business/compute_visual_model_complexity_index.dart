import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// "Complexity Index: analyzes the connections in the Visual Model
/// (222) to assign a Complexity Score" (Issue #233) — node count plus
/// parent-child edge count; a structural-size proxy, not a real
/// graph-theoretic complexity metric (see PR notes).
class ComputeVisualModelComplexityIndex {
  static double call(List<RequirementNode> nodes) {
    if (nodes.isEmpty) return 0;
    final edgeCount = nodes.where((n) => n.parentId != null).length;
    return (nodes.length + edgeCount).toDouble();
  }
}
