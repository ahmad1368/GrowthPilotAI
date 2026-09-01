import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Constraint configuration form for an approved, unconstrained
/// request (Issue #409). Returns the chosen caps or null if
/// cancelled/invalid.
Future<({int requestId, int days, int impressions, int clicks})?> showAdConstraintDialog(
    BuildContext context, List<AdvertisingRequestEntity> unconstrained) {
  return showShadDialog<({int requestId, int days, int impressions, int clicks})>(
    context: context,
    builder: (context) => AdConstraintDialogContent(unconstrained: unconstrained),
  );
}
