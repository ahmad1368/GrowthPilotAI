import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/service_restriction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/service_restriction_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Quick-add form for logging a service block/unblock decision (Issue
/// #337). Returns the new restriction record (not yet persisted) or
/// null if cancelled/invalid.
Future<ServiceRestrictionEntity?> showServiceRestrictionDialog(
    BuildContext context) {
  return showShadDialog<ServiceRestrictionEntity>(
    context: context,
    builder: (context) => const ServiceRestrictionDialogContent(),
  );
}
