import 'package:flutter/foundation.dart';

/// One step in a business process graph (Issue #223) — the client-side,
/// local equivalent of a React Flow node in `canvas_state`.
@immutable
class ProcessNode {
  final String id;
  final String label;

  const ProcessNode({required this.id, required this.label});
}
