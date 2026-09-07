import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/security_audit_log_controller.dart';
import 'package:growth_pilot_ai/core/data/repositories/security_audit_log_repository.dart';
import 'package:growth_pilot_ai/features/settings/widgets/security_audit_log_viewer.dart';

/// [Issue #804] Hosts the existing (previously unwired) Issue #186
/// security-audit-log viewer, reached from the drawer's "Security Center"
/// item, which used to be a no-op.
class SecurityCenterScreen extends StatefulWidget {
  const SecurityCenterScreen({super.key});

  @override
  State<SecurityCenterScreen> createState() => _SecurityCenterScreenState();
}

class _SecurityCenterScreenState extends State<SecurityCenterScreen> {
  final _controller = Get.put(SecurityAuditLogController(GetIt.I<SecurityAuditLogRepository>()));

  @override
  void dispose() {
    Get.delete<SecurityAuditLogController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Security Center'), backgroundColor: colors.background),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A chronological, read-only record of sensitive actions on this device.',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12),
              ),
              const SizedBox(height: 16),
              SecurityAuditLogViewer(controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}
