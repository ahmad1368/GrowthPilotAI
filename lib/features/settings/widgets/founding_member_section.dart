import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/founding_member_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/founding_member_badge.dart';

/// "Dynamic Counter: 'X spots left'" + claim/badge flow (Issue #191)
/// — [businessId] is this app's single local business; no real
/// multi-tenant auth exists here (see PR notes).
class FoundingMemberSection extends StatelessWidget {
  final String businessId;

  const FoundingMemberSection({super.key, required this.businessId});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<FoundingMemberController>();

    return Obx(() {
      final spot = controller.spotFor(businessId);
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${controller.spotsRemaining.value} spots left — free 6 months Premium',
              style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (spot != null)
            FoundingMemberBadge(spotNumber: spot.spotNumber)
          else
            ShadButton(
              onPressed: controller.spotsRemaining.value == 0 ? null : () => controller.claimSpot(businessId),
              child: const Text('Claim Founding Member spot'),
            ),
        ]),
      );
    });
  }
}
