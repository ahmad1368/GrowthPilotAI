import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'notification_card.dart';
import 'adaptive_text.dart';
import 'dart:ui';
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
      // ۱. این خط باعث می‌شود کادر مستطیلی و کدرِ پیش‌فرض حذف شود
      backgroundColor: Colors.transparent,

      // ۲. این خط فضای بیرون از منو را به صورت نیمه‌شفاف تیره می‌کند تا منوی شیشه‌ای بهتر دیده شود
      barrierColor: Colors.black.withValues(alpha: 0.9),
      builder: (context) => Container(
        // تنظیم ارتفاع دقیق بین نوار عنوان و نوار ابزار
        height: MediaQuery.of(context).size.height -
            (kToolbarHeight +
                MediaQuery.of(context).padding.top +
                kBottomNavigationBarHeight),
        child: Stack(
          children: [
            // ۱. لایه مات‌کننده (بلر) پشت پنل (اختیاری، برای عمق بیشتر)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(color: Colors.transparent),
              ),
            ),

            // ۲. خودِ پنل شیشه‌ای (این بخش حس قدیمی را از بین می‌برد)
            Positioned.fill(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: 15, sigmaY: 15), // بلر داخلی پنل
                  child: Container(
                    decoration: BoxDecoration(
                      // استفاده از گرادینت نیمه‌شفاف به جای رنگ تخت
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white
                              .withValues(alpha: 0.08), // درخشش بیشتر در بالا
                          Colors.white
                              .withValues(alpha: 0.03), // شفاف‌تر در پایین
                        ],
                      ),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(30)),
                      border: Border.all(
                        color: Colors.white
                            .withValues(alpha: 0.15), // حاشیه باریک شیشه‌ای
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: -2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        // دستگیره مدرن بالای صفحه
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 20),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  // تیتر مدرن
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // خط دکوراتیو نئونی
                                  Container(
                                    height: 2,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        gradient: const LinearGradient(colors: [
                                          Colors.cyanAccent,
                                          Colors.transparent
                                        ])),
                                  ),
                                  const SizedBox(height: 25),
                                  // متن اصلی
                                  Text(
                                    item.body,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.7,
                                      color:
                                          Colors.white.withValues(alpha: 0.8),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 100), // فضا برای دکمه ثابت پایین
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ۳. دکمه ضربدر خروج ثابت (بالا سمت راست)
            Positioned(
              top: 15,
              right: 15,
              child: IconButton(
                icon: Icon(Icons.close_rounded,
                    color: Colors.white.withValues(alpha: 0.5), size: 24),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // ۴. دکمه "Got it" شیشه‌ای ثابت در پایین (شیک و نئونی)
            Positioned(
              bottom: 30,
              left: 40,
              right: 40,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 5, sigmaY: 5), // بلر اختصاصی دکمه
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.cyanAccent.withValues(alpha: 0.3)),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 12),
                        ),
                        child: const Text(
                          "Understood",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
