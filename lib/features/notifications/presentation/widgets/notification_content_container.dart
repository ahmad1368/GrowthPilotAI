import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/notification_list_view.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
// 💡 اضافه کردن امپورت‌های مفقود شده لایه ویجت‌های فرزند برای رفع خطای کامپایل
import 'notification_grid_view.dart';

class NotificationContentContainer extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;
  final Function(AppNotification) onDelete;

  const NotificationContentContainer({
    super.key,
    required this.notifications,
    required this.onRead,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return Center(
        child: Text(
          "No messages yet",
          style: ShadTheme.of(context).textTheme.p.copyWith(
                color: const Color(0xff71717a),
              ),
        ),
      );
    }

    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isWide = UIHelper.isWide(context);

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: isWide ? 600 : double.infinity),
        child: isWide
            ? NotificationGridView(
                notifications: notifications,
                onRead: onRead,
                onDelete: onDelete,
              )
            : NotificationListView(
                notifications: notifications,
                onRead: onRead,
                onDelete: onDelete,
              ),
      ),
    );
  }
}
