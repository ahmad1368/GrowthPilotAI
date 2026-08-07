import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_financing_fee.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Checkout financing fields with a live, transparent fee preview
/// (Issue #419, acceptance criterion 2).
class MicroCreditFields extends StatefulWidget {
  final MicroCreditFormController form;

  const MicroCreditFields({super.key, required this.form});

  @override
  State<MicroCreditFields> createState() => _MicroCreditFieldsState();
}

class _MicroCreditFieldsState extends State<MicroCreditFields> {
  @override
  Widget build(BuildContext context) {
    final principal = double.tryParse(widget.form.principal.text) ?? 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Seller/supplier name'), controller: widget.form.sellerName),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Item being purchased'), controller: widget.form.itemDescription),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Amount to finance (\$)'),
            controller: widget.form.principal,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {})),
        const SizedBox(height: 8),
        ValueListenableBuilder<int>(
          valueListenable: widget.form.termDays,
          builder: (context, term, _) => Row(children: [
            for (final days in [30, 60])
              ShadButton.outline(
                  onPressed: () => widget.form.termDays.value = days,
                  child: Text(term == days ? '● $days days' : '$days days')),
            const SizedBox(width: 8),
            Text('Fee: \$${ComputeFinancingFee.call(principal, term).toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 12)),
          ]),
        ),
      ],
    );
  }
}
