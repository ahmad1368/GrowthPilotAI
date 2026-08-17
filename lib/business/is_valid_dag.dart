import 'package:growth_pilot_ai/core/models/requirement_node.dart';

/// "Data Integrity" guard (Issue #219, section 2): true only if the
/// parent-child structure has no cycles — walks each node's parent
/// chain and fails as soon as a chain revisits a node it's already
/// seen, which is exactly the condition that would send `graphview`
/// into an infinite rendering loop.
class IsValidDag {
  static bool call(List<RequirementNode> nodes) {
    final byId = {for (final n in nodes) n.id: n};

    for (final node in nodes) {
      final seen = <String>{node.id};
      var current = node.parentId;
      while (current != null) {
        if (seen.contains(current)) return false;
        seen.add(current);
        current = byId[current]?.parentId;
      }
    }
    return true;
  }
}
