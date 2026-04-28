import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'adaptive_text.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification item;
  final VoidCallback onTap;
  final VoidCallback onDelete; // پارامتر جدید برای حذف

  const NotificationCard(
      {super.key,
      required this.item,
      required this.onTap,
      required this.onDelete});

  Map<String, dynamic> _getStyle(NotificationType type) {
    switch (type) {
      case NotificationType.danger:
        return {'icon': Icons.dangerous_rounded, 'color': Colors.redAccent};
      case NotificationType.warning:
        return {
          'icon': Icons.warning_amber_rounded,
          'color': Colors.orangeAccent
        };
      case NotificationType.reminder:
        return {
          'icon': Icons.notifications_active_rounded,
          'color': Colors.lightBlueAccent
        };
      case NotificationType.alert:
        return {
          'icon': Icons.emergency_share_rounded,
          'color': Colors.cyanAccent
        };
      default:
        return {'icon': Icons.info_outline_rounded, 'color': Colors.grey};
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = _getStyle(item.type);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: theme.dividerColor.withOpacity(0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              backgroundColor: (style['color'] as Color).withOpacity(0.1),
              child: Icon(style['icon'], color: style['color']),
            ),
            if (!item.isRead)
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: theme.scaffoldBackgroundColor, width: 2),
                ),
              ),
          ],
        ),
        title:
            AdaptiveText(item.title, fontWeight: FontWeight.bold, fontSize: 14),
        subtitle: AdaptiveText(
          item.body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          fontSize: 12,
          style: TextStyle(
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6)),
        ),
        // بخش دکمه‌ها در سمت راست
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.isRead
                  ? Icons.drafts_outlined
                  : Icons.mark_email_unread_outlined,
              size: 18,
              color: item.isRead ? Colors.grey : Colors.cyanAccent,
            ),
            const SizedBox(width: 8),
            // دکمه ضربدر برای حذف
            IconButton(
              icon: const Icon(Icons.close_rounded,
                  size: 20, color: Colors.redAccent),
              onPressed: onDelete,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
