import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/kyc_admin_review_controller.dart';
import 'package:growth_pilot_ai/features/admin/widgets/kyc_review_row.dart';

/// The reactive queue body of [KycReviewQueueScreen], split out to keep
/// the screen file under the file's SRP line budget.
class KycReviewList extends StatelessWidget {
  final KycAdminReviewController controller;
  final String adminId;

  const KycReviewList({super.key, required this.controller, required this.adminId});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          children: controller.pending
              .map((submission) => KycReviewRow(
                    submission: submission,
                    onApprove: () => controller.decide(adminId, submission, approve: true),
                    onReject: () => controller.decide(adminId, submission, approve: false),
                  ))
              .toList(),
        ));
  }
}
