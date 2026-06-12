import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/navigation/controllers/navigation_controller.dart';
import 'package:growth_pilot_ai/widgets/home_bottom_nav.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      body: Stack(
        children: [
          Obx(() => IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  Center(child: Text("Home", style: theme.textTheme.p)),
                  Center(child: Text("Insights", style: theme.textTheme.p)),
                  const SizedBox.shrink(),
                  Center(child: Text("Profile", style: theme.textTheme.p)),
                  Center(child: Text("Settings", style: theme.textTheme.p)),
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() =>
                HomeBottomNav(currentIndex: controller.currentIndex.value)),
          ),
        ],
      ),
    );
  }
}
