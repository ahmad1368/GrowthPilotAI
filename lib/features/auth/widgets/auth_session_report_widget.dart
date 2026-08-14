import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/auth/widgets/auth_session_body.dart';

/// Registers the Unified Authentication Flow session-lifecycle demo
/// (Issue #120) as a pluggable report widget under id
/// `AUTH_SESSION_LIFECYCLE` (#111).
class AuthSessionReportWidget extends BaseReportWidget {
  const AuthSessionReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const AuthSessionBody();
  }
}
