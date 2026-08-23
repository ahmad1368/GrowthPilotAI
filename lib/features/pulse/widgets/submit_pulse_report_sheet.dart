import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/core/enum/pulse_category.dart';
import 'package:growth_pilot_ai/validators/pulse_report_validator.dart';

/// "Report live business bottlenecks, regulatory updates, or
/// financial blockers" (Issue #267/#268) — the report submission
/// form, validated via [PulseReportValidator] before [onSubmit] runs.
class SubmitPulseReportSheet extends StatefulWidget {
  final void Function(PulseCategory category, String title, String description, String region, double impact)
      onSubmit;

  const SubmitPulseReportSheet({super.key, required this.onSubmit});

  @override
  State<SubmitPulseReportSheet> createState() => _SubmitPulseReportSheetState();
}

class _SubmitPulseReportSheetState extends State<SubmitPulseReportSheet> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _region = TextEditingController();
  final _impact = TextEditingController();
  PulseCategory _category = PulseCategory.financialBlocker;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _region.dispose();
    _impact.dispose();
    super.dispose();
  }

  void _submit() {
    final impact = double.tryParse(_impact.text.trim());
    final error = PulseReportValidator.title(_title.text) ??
        PulseReportValidator.description(_description.text) ??
        PulseReportValidator.estimatedImpactCad(impact);
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    widget.onSubmit(_category, _title.text.trim(), _description.text.trim(), _region.text.trim(), impact!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      ShadSelect<PulseCategory>(
        initialValue: _category,
        options: PulseCategory.values.map((c) => ShadOption(value: c, child: Text(c.label))).toList(),
        selectedOptionBuilder: (context, value) => Text(value.label),
        onChanged: (value) {
          if (value != null) setState(() => _category = value);
        },
      ),
      const SizedBox(height: 8),
      ShadInput(controller: _title, placeholder: const Text('Title')),
      const SizedBox(height: 8),
      ShadInput(controller: _description, placeholder: const Text('What happened?')),
      const SizedBox(height: 8),
      ShadInput(controller: _region, placeholder: const Text('Region (e.g. BC, ON)')),
      const SizedBox(height: 8),
      ShadInput(
          controller: _impact,
          placeholder: const Text('Estimated impact (CAD)'),
          keyboardType: TextInputType.number),
      const SizedBox(height: 12),
      ShadButton(onPressed: _submit, child: const Text('Submit Report')),
    ]);
  }
}
