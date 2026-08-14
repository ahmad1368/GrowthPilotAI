import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders active online-checkout holds + a reserve button (Issue #445).
/// Purely presentational — [StockReservationSection] owns the list.
class StockReservationView extends StatelessWidget {
  final List<StockReservationEntity> reservations;
  final VoidCallback onReserve;
  final ValueChanged<StockReservationEntity> onConfirm;
  final ValueChanged<StockReservationEntity> onRelease;

  const StockReservationView({
    super.key,
    required this.reservations,
    required this.onReserve,
    required this.onConfirm,
    required this.onRelease,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text('Active online-checkout locks', style: label)),
            ShadButton.outline(
              onPressed: onReserve,
              child: Text('+ Reserve Online', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (reservations.isEmpty)
          const Text('No active online-checkout locks.')
        else
          for (final r in reservations)
            StockReservationRow(
                reservation: r, onConfirm: () => onConfirm(r), onRelease: () => onRelease(r)),
      ],
    );
  }
}
