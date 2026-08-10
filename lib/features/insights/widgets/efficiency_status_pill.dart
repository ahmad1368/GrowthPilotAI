import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/efficiency_gap_status.dart';

/// The colored status label on [EfficiencyGapBar], split out to keep the
/// bar under the file's SRP line budget.
class EfficiencyStatusPill extends StatelessWidget {
  final EfficiencyGapStatus status;

  const EfficiencyStatusPill({super.key, required this.status});

  Color get _color => switch (status) {
        EfficiencyGapStatus.excellentDeal => Colors.green,
        EfficiencyGapStatus.fairValue => Colors.orange,
        EfficiencyGapStatus.belowAverage => Colors.red,
      };

  String get _label => switch (status) {
        EfficiencyGapStatus.excellentDeal => 'Excellent Deal',
        EfficiencyGapStatus.fairValue => 'Fair Value',
        EfficiencyGapStatus.belowAverage => 'Below Average',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(12)),
      child: Text(_label,
          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
