import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// In-store register vs. online storefront picker for a new stock movement
/// (Issue #445).
class StockMovementChannelSelect extends StatelessWidget {
  final SalesChannel channel;
  final ValueChanged<SalesChannel?> onChanged;

  const StockMovementChannelSelect({super.key, required this.channel, required this.onChanged});

  static String _label(SalesChannel c) => c == SalesChannel.pos ? 'In-Store (POS)' : 'Online';

  @override
  Widget build(BuildContext context) {
    return ShadSelect<SalesChannel>(
      initialValue: channel,
      placeholder: const Text('Sales channel'),
      options: [
        for (final c in SalesChannel.values) ShadOption(value: c, child: Text(_label(c)))
      ],
      selectedOptionBuilder: (context, value) => Text(_label(value)),
      onChanged: onChanged,
    );
  }
}
