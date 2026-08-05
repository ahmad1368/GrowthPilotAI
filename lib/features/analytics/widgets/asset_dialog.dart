import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New asset listing wizard (Issue #412, acceptance criterion 1).
/// Returns the new listing (not yet persisted) or null if
/// cancelled/invalid.
Future<AssetListingEntity?> showAssetDialog(BuildContext context) {
  return showShadDialog<AssetListingEntity>(
    context: context,
    builder: (context) => const AssetDialogContent(),
  );
}
