import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/delete_all_local_data.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/widgets/app_notifier.dart';
import 'package:growth_pilot_ai/features/settings/widgets/delete_account_dialog.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_nav_tile.dart';

/// [Issue #808 audit] Account actions, Settings > Account & Security.
/// The former "Profile Settings" entry here had no onTap and no
/// destination screen anywhere in the app — removed rather than left as
/// a silent no-op, per this issue's own acceptance criteria.
class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsNavTile(
      icon: Icons.delete_forever_rounded,
      title: 'Delete Account',
      subtitle: 'Permanently erase all local data on this device',
      onTap: () => _deleteAccount(context),
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    final confirmed = await showDeleteAccountDialog(context);
    if (confirmed != true) return;

    await DeleteAllLocalData.call(Get.find<ObjectBox>());
    AppNotifier.show(
      title: 'Account deleted',
      message: 'Close and reopen the app to finish resetting it.',
      type: AppNotificationType.success,
    );
  }
}
