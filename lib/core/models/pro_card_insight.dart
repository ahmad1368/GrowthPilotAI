import 'package:flutter/foundation.dart';

/// Display-ready content for one "Like the Pros" card (Issue #85 scope
/// item 2: "Insight" + "Action" sections).
@immutable
class ProCardInsight {
  final String insightText;
  final String actionLabel;

  const ProCardInsight({required this.insightText, required this.actionLabel});
}
