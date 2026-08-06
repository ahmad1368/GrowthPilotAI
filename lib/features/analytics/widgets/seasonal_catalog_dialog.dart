import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New seasonal catalog line wizard (Issue #417, acceptance criterion
/// 1). Returns the new line (not yet persisted) or null if
/// cancelled/invalid.
Future<SeasonalCatalogItemEntity?> showSeasonalCatalogDialog(BuildContext context) {
  return showShadDialog<SeasonalCatalogItemEntity>(
    context: context,
    builder: (context) => const SeasonalCatalogDialogContent(),
  );
}
