import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_depletion_forecast_body_state.dart';

/// Owns the selected lookback period (Issue #360); state logic lives in
/// [StockDepletionForecastBodyState].
class StockDepletionForecastBody extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final List<StockMovementEntity> movements;

  const StockDepletionForecastBody(
      {super.key, required this.items, required this.movements});

  @override
  State<StockDepletionForecastBody> createState() =>
      StockDepletionForecastBodyState();
}
