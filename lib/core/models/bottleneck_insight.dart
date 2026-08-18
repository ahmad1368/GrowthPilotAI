import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';

/// One detected process issue (Issue #223) — mirrors the issue's own
/// "Insight Payload" JSON shape exactly (nodeId/issue/severity/reason/
/// suggestion), computed locally rather than by a Node.js/Python
/// analysis service (see PR notes).
@immutable
class BottleneckInsight {
  final String nodeId;
  final String issueLabel;
  final BottleneckSeverity severity;
  final String reason;
  final String suggestion;

  const BottleneckInsight({
    required this.nodeId,
    required this.issueLabel,
    required this.severity,
    required this.reason,
    required this.suggestion,
  });
}
