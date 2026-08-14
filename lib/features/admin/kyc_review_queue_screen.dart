import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/kyc_admin_review_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/admin/widgets/kyc_review_list.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "KYC Approval Queue" (Issue #151) — flat shadcn_ui, not Glassmorphism.
/// Not yet wired into app navigation (same as KycVerificationScreen).
class KycReviewQueueScreen extends StatefulWidget {
  final String adminId;
  const KycReviewQueueScreen({super.key, required this.adminId});

  @override
  State<KycReviewQueueScreen> createState() => _KycReviewQueueScreenState();
}

class _KycReviewQueueScreenState extends State<KycReviewQueueScreen> {
  late final KycAdminReviewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(KycAdminReviewController());
    _controller.loadQueue();
  }

  @override
  void dispose() {
    Get.delete<KycAdminReviewController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark ? const Color(0xFF09090B) : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('KYC Approval Queue')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: KycReviewList(controller: _controller, adminId: widget.adminId),
        ),
      ),
    );
  }
}
