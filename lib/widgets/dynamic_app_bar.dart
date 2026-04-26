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
    AppNotification(title: "AI Analysis", message: "Your weekly report is ready."),
    AppNotification(title: "Security Update", message: "New login detected in Coquitlam."),
    AppNotification(title: "Marketplace", message: "A new client is interested in your project."),
    AppNotification(title: "System", message: "GrowthPilot v1.0.5 is now stable."),
    AppNotification(title: "Billing", message: "Invoice for April has been generated."),
    AppNotification(title: "Reminder", message: "Don't forget to check your daily insights."),
    AppNotification(title: "New Lead", message: "Someone viewed your professional profile."),
    AppNotification(title: "Cloud Summit", message: "New updates available for the mobile app."),
    AppNotification(title: "Azure Info", message: "AZ-900 study materials updated."),
    AppNotification(title: "Notification 10", message: "Example notification number 10"),
    AppNotification(title: "Notification 11", message: "Example notification number 11"),
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