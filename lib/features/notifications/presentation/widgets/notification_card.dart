import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/action_buttons.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/badge_icon.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../utils/notification_style_mapper.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationCard(
      {super.key,
      required this.item,
      required this.onTap,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final style = NotificationStyleMapper.getStyle(item.type);
    final iconColor = style['color'] as Color;

    return ShadCard(
      backgroundColor:
          isDark ? const Color(0xff18181b) : const Color(0xffffffff),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      content: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: BadgeIcon(
            item: item, style: style, iconColor: iconColor, isDark: isDark),
        title: Text(
          item.title,
          style: ShadTheme.of(context).textTheme.h4.copyWith(
                color: isDark ? Colors.white : Colors.black,
              ),
        ),
        subtitle: Text(
          item.body,
          style: ShadTheme.of(context).textTheme.small.copyWith(
                color: (isDark ? Colors.white : Colors.black)
                    .withValues(alpha: 0.6),
              ),
        ),
        trailing: ActionButtons(item: item, isDark: isDark, onDelete: onDelete),
      ),
    );
  }
}
