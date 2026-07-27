import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_section.dart';

/// Registers the Real-Time Stock Tracking Engine widget (Issue #439) as a
/// pluggable report widget under id `STOCK_MOVEMENT` (#111). Unifies the
/// in-store movement ledger with online-checkout locks (Issue #445).
class StockMovementReportWidget extends BaseReportWidget {
  const StockMovementReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final items = data['items'] as List<InventoryItemEntity>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StockMovementBody(
          initialMovements: data['movements'] as List<StockMovementEntity>,
          items: items,
        ),
        StockReservationSection(
          initialReservations: data['reservations'] as List<StockReservationEntity>,
          items: items,
        ),
      ],
    );
  }
}
