import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/presentation/widgets/db_status_actions.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DbStatusPanel extends StatelessWidget {
  const DbStatusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = UIHelper.isWide(context);

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.all(16),
      width: UIHelper.getAdaptiveWidth(context),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.sd_storage_rounded,
                color: const Color(0xff2563eb), size: 24),
            title: Text(
              "ObjectBox SDK",
              style: ShadTheme.of(context).textTheme.h4.copyWith(
                    color: isDark ? Colors.white : Colors.black,
                  ),
            ),
            subtitle: Text(
              "Status: Secured with AES-256",
              style: ShadTheme.of(context).textTheme.small,
            ),
            trailing: Icon(
              Icons.verified_user_rounded,
              color: isDark ? const Color(0xff4ade80) : const Color(0xff16a34a),
            ),
          ),
          const Divider(color: Colors.white10, height: 20),
          DbStatusActions(isWide: isWide),
        ],
      ),
    );
  }
}
