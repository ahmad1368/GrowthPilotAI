import 'dart:ui';
import 'package:flutter/material.dart';
import 'omni_glass_panel.dart';
import '../models/notification_model.dart';
import 'notification_card.dart';
import 'adaptive_text.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import '../utils/responsive_helper.dart';

class NotificationSheet extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;
  final Function(AppNotification) onDelete; // قابلیت حذف اضافه شد

  const NotificationSheet({
    super.key,
    required this.notifications,
    required this.onRead,
    required this.onDelete,
  });

  // متد نمایش جزئیات کامل نوتیفیکیشن
  void _showDetails(BuildContext context, AppNotification item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => OmniGlassPanel(
        title: item.title,
        description: item.body,
        showCloseButton: true,
        avoidSystemBars: true,
        actionButtons: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Understand Insight"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = AdaptiveTheme.of(context).mode.isDark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.6),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.05),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              // دسته بالای منو (Handle)
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.black.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: AdaptiveText(
                  "NOTIFICATIONS",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              ),

              Divider(
                color: isDarkMode ? Colors.white10 : Colors.black12,
                height: 1,
              ),

              Expanded(
                child: notifications.isEmpty
                    ? Center(
                        child: AdaptiveText(
                          "No messages yet",
                          style: TextStyle(color: theme.hintColor),
                        ),
                      )
                    : ResponsiveHelper.isMobile(context)
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 20, top: 10),
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final item = notifications[index];
                              return NotificationCard(
                                item: item,
                                onTap: () {
                                  onRead(item);
                                  _showDetails(context, item);
                                },
                                onDelete: () => onDelete(item),
                              );
                            },
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 90,
                            ),
                            itemCount: notifications.length,
                            itemBuilder: (context, index) {
                              final item = notifications[index];
                              return NotificationCard(
                                item: item,
                                onTap: () {
                                  onRead(item);
                                  _showDetails(context, item);
                                },
                                onDelete: () => onDelete(item),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
