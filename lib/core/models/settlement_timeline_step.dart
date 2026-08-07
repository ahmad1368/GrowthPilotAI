/// One stage of a settlement's visual progress timeline (Issue #426,
/// acceptance criterion 2).
class SettlementTimelineStep {
  final String label;
  final bool isApplicable;
  final bool isComplete;
  final bool isCurrent;

  const SettlementTimelineStep({
    required this.label,
    this.isApplicable = true,
    required this.isComplete,
    required this.isCurrent,
  });
}
