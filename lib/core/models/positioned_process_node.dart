import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/process_node.dart';

/// A [ProcessNode] placed at auto-computed canvas coordinates (Issue
/// #224's "send the (x, y) coordinates to Flutter") — computed on-device
/// (see [ComputeLayeredLayout]), not by a Node.js `dagre`/`d3-force`
/// service (see PR notes).
@immutable
class PositionedProcessNode {
  final ProcessNode node;
  final double x;
  final double y;

  const PositionedProcessNode({required this.node, required this.x, required this.y});
}
