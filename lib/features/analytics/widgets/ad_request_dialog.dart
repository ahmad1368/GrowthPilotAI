import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_request_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Self-service advertising request form (Issue #401). Returns the new
/// request (not yet persisted) or null if cancelled/invalid.
Future<AdvertisingRequestEntity?> showAdRequestDialog(BuildContext context) {
  return showShadDialog<AdvertisingRequestEntity>(
    context: context,
    builder: (context) => const AdRequestDialogContent(),
  );
}
