import 'dart:ui';
import 'package:flutter/material.dart';
import 'neon_icon.dart'; // مطمئن شو مسیر این فایل درست است
import 'notification_sheet.dart';
import '../models/notification_model.dart';

class DynamicAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double scrollOffset;
  final String title;

  const DynamicAppBar({
    super.key,
    required this.scrollOffset,
    required this.title,
  });

  @override
  State<DynamicAppBar> createState() => _DynamicAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DynamicAppBarState extends State<DynamicAppBar> {
  // ۱. آرایه ۱۱ تایی از نوتیفیکیشن‌ها (قابل جایگزینی با API در آینده)
  final List<AppNotification> _notifications = List.generate(11, (index) {
    return AppNotification(
      id: (index + 1).toString(),
      title: _getThemeTitle(index),
      body: _getThemeBody(index),
      footer: _getThemeFooter(index),
      date: DateTime.now().subtract(Duration(hours: index, minutes: index * 2)),
      isRead: false,
    );
  });

  // متدهای کمکی برای تولید دیتای متنوع در حلقه
  static String _getThemeTitle(int i) =>
      ["AI Analysis", "Security", "Market", "System"][i % 4];
  static String _getThemeBody(int i) =>
      "گزارش شماره ${i + 1} برای پروژه GrowthPilotAI آماده بررسی است.";
  static String _getThemeFooter(int i) =>
      ["Analytics", "Safety", "Leads", "Logs"][i % 4];

  @override
  Widget build(BuildContext context) {
    final double progress = (widget.scrollOffset / 200).clamp(0.0, 1.0);
    int unreadCount = _notifications.where((n) => !n.isRead).length;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: progress * 15, sigmaY: progress * 15),
        child: AppBar(
          backgroundColor: Colors.black.withOpacity(progress * 0.5),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.8 + (progress * 0.2)),
            ),
          ),
          actions: [
            _buildNotificationBell(unreadCount),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBell(int count) {
    return IconButton(
      onPressed: () => _openNotificationOverlay(),
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          const NeonIcon(
            icon: Icons.notifications_none_rounded,
            size: 26,
            opacity: 0.9,
          ),
          if (count > 0)
            Positioned(
              right: -2,
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  count > 9 ? '9+' : count.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _openNotificationOverlay() {
    // مستقیم از دستور فلاتر استفاده کن، نه از طریق NotificationService
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return NotificationSheet(
            notifications:
                _notifications, // لیست نوتیفیکیشن‌ها که در AppBar داری
            onRead: (notification) {
              setState(() {
                notification.isRead = true;
              });
            },
            onDelete: (item) {});
      },
    );
  }
}
