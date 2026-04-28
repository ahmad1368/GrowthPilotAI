import 'dart:ui';
import 'package:flutter/material.dart';
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
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          // ۱. محاسبه ارتفاع دقیق: کل صفحه منهای ارتفاع نوار عنوان و نوار ابزار
          height: MediaQuery.of(context).size.height -
              (kToolbarHeight +
                  MediaQuery.of(context).padding.top +
                  kBottomNavigationBarHeight),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              // نوار کوچک بالای دراور برای بستن
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdaptiveText(
                          item.title,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: Colors.white10),
                        const SizedBox(height: 16),
                        AdaptiveText(
                          item.body,
                          style: const TextStyle(fontSize: 16, height: 1.8),
                        ),
                        const SizedBox(height: 40),
                        AdaptiveText(
                          "Info: ${item.footer}",
                          fontSize: 12,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // دکمه خروج در انتهای محتوا
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const AdaptiveText("Back to List",
                      style: TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
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
                ? Colors.black.withOpacity(0.6)
                : Colors.white.withOpacity(0.6),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.05),
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
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.1),
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
