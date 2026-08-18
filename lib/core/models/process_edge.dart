import 'package:flutter/foundation.dart';

/// One directed connection between two [ProcessNode]s (Issue #223).
@immutable
class ProcessEdge {
  final String sourceId;
  final String targetId;

  const ProcessEdge({required this.sourceId, required this.targetId});
}
