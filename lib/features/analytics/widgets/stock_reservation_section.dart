import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_section_state.dart';

/// Owns the active-reservation list (Issue #445); state logic lives in
/// [StockReservationSectionState].
class StockReservationSection extends StatefulWidget {
  final List<StockReservationEntity> initialReservations;
  final List<InventoryItemEntity> items;

  const StockReservationSection(
      {super.key, required this.initialReservations, required this.items});

  @override
  State<StockReservationSection> createState() => StockReservationSectionState();
}
