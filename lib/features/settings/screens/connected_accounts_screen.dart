import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/connected_accounts_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/connected_accounts_body.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Connected Accounts screen (Issue #68): grouped sub-accounts per
/// institution with a combined-balance header and per-account sync toggles.
class ConnectedAccountsScreen extends StatelessWidget {
  const ConnectedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final controller = Get.find<ConnectedAccountsController>();

    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Connected Accounts')),
        body: Obx(() => RefreshIndicator(
              onRefresh: controller.pullToRefresh,
              child: ConnectedAccountsBody(controller: controller),
            )),
      ),
    );
  }
}
