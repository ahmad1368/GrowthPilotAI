import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/exchange_rate_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/exchange_rate_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging an FX rate observation (Issue #371).
/// Returns the new observation (not yet persisted) or null if
/// cancelled/invalid.
Future<ExchangeRateObservationEntity?> showExchangeRateDialog(
    BuildContext context) {
  return showShadDialog<ExchangeRateObservationEntity>(
    context: context,
    builder: (context) => const ExchangeRateDialogContent(),
  );
}
