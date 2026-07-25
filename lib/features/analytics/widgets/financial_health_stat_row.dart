import 'package:flutter/material.dart';

/// One labeled stat row (Issue #385): label + formatted value.
class FinancialHealthStatRow extends StatelessWidget {
  final String label;
  final String value;

  const FinancialHealthStatRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.7))),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
