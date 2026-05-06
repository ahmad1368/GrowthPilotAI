import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'omni_glass_panel.dart';
import '../models/notification_model.dart';
import 'notification_card.dart';
import 'adaptive_text.dart';

class NotificationSheet extends StatelessWidget {
  final List<AppNotification> notifications;
  final Function(AppNotification) onRead;
  final Function(AppNotification) onDelete;

  const NotificationSheet({
    super.key,
    required this.notifications,
    required this.onRead,
    required this.onDelete,
  });

  // نمایش جزئیات نوتیفیکیشن با استفاده از پنل شیشه‌ای استاندارد
  void _showDetails(BuildContext context, AppNotification item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Center(
        child: Container(
          width: UIHelper.getAdaptiveWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: OmniGlassPanel(
            title: item.title,
            description: item.body,
            showCloseButton: true,
            isInteractive: true,
            actionButtons: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const AdaptiveText("Understand Insight"),
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
    final bool isWide = UIHelper.isWide(context);

    return Center(
      child: Container(
        // عرض تطبیق‌پذیر برای نمایش درست در تبلت و دسکتاپ
        width: isWide ? 600 : double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: OmniGlassPanel(
          opacity: 0.2, // کمی تیره‌تر برای تمایز از صفحه زیرین
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              // دسته بالای منو (Handle)
              Container(
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
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
                  ),
                ),
              ),

              const Divider(color: Colors.white10, height: 1),

              Expanded(
                child: notifications.isEmpty
                    ? const Center(
                        child: AdaptiveText(
                          "No messages yet",
                          style: TextStyle(color: Colors.white38),
                        ),
                      )
                    : _buildNotificationList(context, isWide),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context, bool isWide) {
    if (!isWide) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        itemCount: notifications.length,
        itemBuilder: (context, index) =>
            _buildCard(context, notifications[index]),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        mainAxisExtent: 100,
      ),
      itemCount: notifications.length,
      itemBuilder: (context, index) =>
          _buildCard(context, notifications[index]),
    );
  }

  Widget _buildCard(BuildContext context, AppNotification item) {
    return NotificationCard(
      item: item,
      onTap: () {
        onRead(item);
        _showDetails(context, item);
      },
      onDelete: () => onDelete(item),
    );
  }
}
