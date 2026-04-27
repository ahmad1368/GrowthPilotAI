import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/neon_icon.dart';
import 'package:growth_pilot_ai/widgets/notification_sheet.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';

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
  // لیست نوتیفیکیشن‌ها با مدل واحد
  final List<AppNotification> _notifications = [
  AppNotification(
    id: "1",
    title: "AI Analysis",
    body: "Your weekly report is ready. All metrics show a 15% growth in performance.",
    footer: "System Engine • Analytics",
    date: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  AppNotification(
    id: "2",
    title: "Security Update",
    body: "New login detected in Coquitlam. If this wasn't you, please secure your account.",
    footer: "Security Center",
    date: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  AppNotification(
    id: "3",
    title: "Marketplace",
    body: "A new client is interested in your project. Check the 'Leads' section for details.",
    footer: "Surrey Professional Market",
    date: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  AppNotification(
    id: "4",
    title: "System",
    body: "GrowthPilot v1.0.8 is now stable. All themes and glass widgets are optimized.",
    footer: "Release Notes",
    date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  AppNotification(
    id: "5",
    title: "Billing",
    body: "Invoice for April has been generated. You can download the PDF in settings.",
    footer: "Accounts",
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  AppNotification(
    id: "6",
    title: "Reminder",
    body: "Don't forget to check your daily insights. Today's target is 500 units.",
    footer: "Daily Tasks",
    date: DateTime.now().subtract(const Duration(days: 2)),
  ),
  AppNotification(
    id: "7",
    title: "New Lead",
    body: "Someone viewed your professional profile. They searched for 'Flutter Developer'.",
    footer: "Profiles",
    date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  AppNotification(
    id: "8",
    title: "Cloud Summit",
    body: "New updates available for the mobile app. Version 1.0.9 is ready for testing.",
    footer: "GitHub Repository",
    date: DateTime.now().subtract(const Duration(days: 4)),
  ),
  AppNotification(
    id: "9",
    title: "Azure Info",
    body: "AZ-900 study materials updated. New module on ExpressRoute is now available.",
    footer: "Microsoft Learn",
    date: DateTime.now().subtract(const Duration(days: 5)),
  ),
  AppNotification(
    id: "10",
    title: "Update Required",
    body: "Please update your Fair PharmaCare documentation for BC health coverage.",
    footer: "Administration",
    date: DateTime.now().subtract(const Duration(days: 6)),
  ),
  AppNotification(
    id: "11",
    title: "Final Sync",
    body: "Database synchronization completed successfully. 1.2GB of assets moved.",
    footer: "Asset Management",
    date: DateTime.now().subtract(const Duration(days: 7)),
  ),
];

  @override
  Widget build(BuildContext context) {
    final double progress = (widget.scrollOffset / 200).clamp(0.0, 1.0);
    
    // شمارش نوتیفیکیشن‌های خوانده نشده
    int unreadCount = _notifications.where((n) => !n.isRead).length;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: progress * 20, sigmaY: progress * 20),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(progress * 0.7),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.white.withOpacity(0.7 + (progress * 0.3)),
            ),
          ),
          actions: [
            _buildNotificationBell(unreadCount),
            const SizedBox(width: 8),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(progress * 0.1),
                  width: 0.8,
                ),
              ),
            ),
          ),
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
            size: 28,
            opacity: 0.8,
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
                constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                child: Text(
                  count > 9 ? '9+' : count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _openNotificationOverlay() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        // استفاده از StatefulBuilder برای مدیریت وضعیت لحظه‌ای داخل مودال
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setSheetState) {
            return NotificationSheet(
              notifications: _notifications,
              onRead: (notification) {
                // ۱. تغییر وضعیت در لیست اصلی (برای زنگوله در AppBar)
                setState(() {
                  notification.isRead = true;
                });
                
                // ۲. تغییر وضعیت در لحظه برای لیست (برای مخفی شدن آنی دایره نئونی)
                setSheetState(() {});
              },
            );
          },
        );
      },
    );
  }
}