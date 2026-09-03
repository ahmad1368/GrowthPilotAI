import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import '../models/notification_model.dart';
import 'notification_card.dart';

/// Flat notification sheet/detail dialog — replaces the former
/// OmniGlassPanel/AdaptiveText wrappers with plain flat containers (matches
/// HomeBottomNav/AppDrawer's pattern) and fixes hardcoded white text/
/// dividers that only looked correct in dark mode.
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

  void _showDetails(BuildContext context, AppNotification item) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Center(
        child: Container(
          width: UIHelper.getAdaptiveWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppDesignTokens.card(theme.brightness),
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Text(item.body,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: onSurface.withValues(alpha: 0.7))),
                const SizedBox(height: 20),
                Divider(color: onSurface.withValues(alpha: 0.08), height: 1),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Understand Insight"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final bool isWide = UIHelper.isWide(context);

    return Center(
      child: Container(
        // عرض تطبیق‌پذیر برای نمایش درست در تبلت و دسکتاپ
        width: isWide ? 600 : double.infinity,
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: AppDesignTokens.card(theme.brightness),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            // دسته بالای منو (Handle)
            Container(
              width: 45,
              height: 4,
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "NOTIFICATIONS",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            Divider(color: onSurface.withValues(alpha: 0.1), height: 1),
            Expanded(
              child: notifications.isEmpty
                  ? Center(
                      child: Text(
                        "No messages yet",
                        style: TextStyle(color: onSurface.withValues(alpha: 0.4)),
                      ),
                    )
                  : _buildNotificationList(context, isWide),
            ),
          ],
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
