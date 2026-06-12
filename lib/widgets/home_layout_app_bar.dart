import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/notification_sheet.dart';
// 💡 اضافه کردن امپورت مدل جهت شناخت صحیح کلاس در زمان کستینگ
import 'notification_badge.dart';

class HomeLayoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int unreadCount;
  final List<dynamic> notifications;
  final VoidCallback onRefresh;
  final Function deleteNotification;

  const HomeLayoutAppBar({
    super.key,
    required this.unreadCount,
    required this.notifications,
    required this.onRefresh,
    required this.deleteNotification,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return AppBar(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: fgColor),
      title: Text(
        "GrowthPilot AI",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: fgColor,
              fontWeight: FontWeight.w700, // شبیه‌سازی وزن ضخیم h4
            ),
      ),
      actions: [
        NotificationBadge(
          count: unreadCount,
          onTap: () => _openNotifications(context),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => Navigator.pushNamed(context, '/settings'),
        ),
      ],
    );
  }

  void _openNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => NotificationSheet(
        // 💡 کست کردن لیست پویا به ساختار تایپ‌پذیر پلتفرم
        notifications: notifications.cast<AppNotification>(),
        onRead: (item) {
          item.isRead = true;
          onRefresh();
        },
        onDelete: (item) => deleteNotification(item.id, onRefresh),
      ),
    );
  }
}
