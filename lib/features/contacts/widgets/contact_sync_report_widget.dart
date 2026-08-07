import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_body.dart';

/// Registers the Privacy-Preserving "Find Friends on App" Contact
/// Sync (Issue #541) as a pluggable report widget under id
/// `CONTACT_SYNC_FIND_FRIENDS` (#111).
class ContactSyncReportWidget extends BaseReportWidget {
  const ContactSyncReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const ContactSyncBody();
  }
}
