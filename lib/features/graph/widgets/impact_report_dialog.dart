import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/requirement_impact_report.dart';

/// "'What-If' Analysis Mode... a preview window showing a
/// red-highlighted list of everything that will need to be
/// re-validated" (Issue #240).
class ImpactReportDialog extends StatelessWidget {
  final RequirementImpactReport report;

  const ImpactReportDialog({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Predicted impact — risk ${report.riskScore}%'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          children: [
            _section('Directly affected goals', report.directGoals.map((g) => g.title)),
            _section('Directly affected test cases', report.directTestCases.map((t) => t.title)),
            _section('Indirectly affected requirements (share a goal)',
                report.indirectRequirements.map((r) => '${r.reqCode} ${r.description}')),
            if (report.possibleContradictions.isNotEmpty)
              _section(
                'Possible contradictions (keyword heuristic, not verified)',
                report.possibleContradictions.map((r) => '${r.reqCode} ${r.description}'),
                color: Colors.red,
              ),
          ],
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close'))],
    );
  }

  Widget _section(String title, Iterable<String> items, {Color? color}) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          for (final item in items) Text('- $item', style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
