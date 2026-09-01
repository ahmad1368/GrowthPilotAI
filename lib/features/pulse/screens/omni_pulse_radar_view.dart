import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/pulse_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/pulse/widgets/pulse_event_card.dart';
import 'package:growth_pilot_ai/features/pulse/widgets/pulse_gratification_banner.dart';
import 'package:growth_pilot_ai/features/pulse/widgets/submit_pulse_report_sheet.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';

/// "Create flat OmniPulseRadarView using responsive grid structures
/// for wide layout and mobile" (Issue #267/#268).
class OmniPulseRadarView extends StatelessWidget {
  const OmniPulseRadarView({super.key});

  @override
  Widget build(BuildContext context) {
    // Bug fix: this screen never had a ShadTheme ancestor, so the
    // ShadTheme.of(context) calls here and in PulseEventCard/
    // PulseGratificationBanner would throw as soon as this rendered.
    final shadTheme = AppShadTheme.build(Theme.of(context).brightness);
    final colors = shadTheme.colorScheme;
    final controller = Get.find<PulseController>();

    return ShadTheme(
      data: shadTheme,
      child: Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('OmniPulse'),
        backgroundColor: colors.background,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Obx(() => Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.military_tech_outlined, size: 16, color: colors.primary),
                    const SizedBox(width: 4),
                    Text('${controller.totalGrowthScore.value}', style: TextStyle(color: colors.foreground)),
                  ])),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openReportSheet(context, controller),
        child: const Icon(Icons.campaign_outlined),
      ),
      body: Obx(() {
        final gratification = controller.lastGratification.value;
        final isWide = UIHelper.isWide(context);
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            if (gratification != null) PulseGratificationBanner(result: gratification),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 2 : 1,
                  mainAxisExtent: 160,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: controller.feed.length,
                itemBuilder: (context, i) => PulseEventCard(
                  event: controller.feed[i],
                  onHelpful: () => controller.markHelpful(controller.feed[i]),
                ),
              ),
            ),
          ]),
        );
      }),
      ),
    );
  }

  void _openReportSheet(BuildContext context, PulseController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
        ),
        child: SubmitPulseReportSheet(onSubmit: (category, title, description, region, impact) {
          controller.submitReport(
            category: category,
            title: title,
            description: description,
            region: region,
            estimatedImpactCad: impact,
          );
          Navigator.of(sheetContext).pop();
        }),
      ),
    );
  }
}
