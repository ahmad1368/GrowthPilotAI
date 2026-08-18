import 'package:growth_pilot_ai/core/models/process_edge.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

/// "Type or paste a text description... AI instantly generates a
/// structured flowchart" (Issue #224) — a deterministic local heuristic,
/// not a real Gemini/OpenAI call (no LLM backend exists in this repo;
/// see PR notes). Two supported inputs: lines containing `->` become
/// explicit edges between the named steps (for branching); otherwise
/// every non-empty line is treated as one step in a straight sequential
/// chain, in the order given.
class ParseTextToProcessGraph {
  static ProcessGraph call(String text) {
    final lines = text.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
    final hasArrows = lines.any((l) => l.contains('->'));

    return hasArrows ? _fromArrowLines(lines) : _fromSequentialLines(lines);
  }

  static ProcessGraph _fromSequentialLines(List<String> lines) {
    final nodes = [for (var i = 0; i < lines.length; i++) ProcessNode(id: 'n$i', label: lines[i])];
    final edges = [
      for (var i = 0; i < nodes.length - 1; i++) ProcessEdge(sourceId: nodes[i].id, targetId: nodes[i + 1].id)
    ];
    return ProcessGraph(nodes: nodes, edges: edges);
  }

  static ProcessGraph _fromArrowLines(List<String> lines) {
    final idByLabel = <String, String>{};
    final nodes = <ProcessNode>[];
    final edges = <ProcessEdge>[];

    String idFor(String label) => idByLabel.putIfAbsent(label, () {
          final id = 'n${idByLabel.length}';
          nodes.add(ProcessNode(id: id, label: label));
          return id;
        });

    for (final line in lines) {
      final parts = line.split('->').map((p) => p.trim()).where((p) => p.isNotEmpty).toList();
      for (var i = 0; i < parts.length - 1; i++) {
        edges.add(ProcessEdge(sourceId: idFor(parts[i]), targetId: idFor(parts[i + 1])));
      }
      if (parts.length == 1) idFor(parts.first);
    }
    return ProcessGraph(nodes: nodes, edges: edges);
  }
}
