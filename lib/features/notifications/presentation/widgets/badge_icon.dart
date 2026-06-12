import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/models/notification_model.dart';

class BadgeIcon extends StatelessWidget {
  final AppNotification item;
  final Map<String, dynamic> style;
  final Color iconColor;
  final bool isDark;

  const BadgeIcon(
      {super.key,
      required this.item,
      required this.style,
      required this.iconColor,
      required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        CircleAvatar(
          backgroundColor: iconColor.withValues(alpha: 0.1),
          child: Icon(style['icon'] as IconData, color: iconColor),
        ),
        if (!item.isRead)
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xff2563eb),
              shape: BoxShape.circle,
              border: Border.all(
                  color: isDark
                      ? const Color(0xff09090b)
                      : const Color(0xffffffff),
                  width: 1.5),
            ),
          ),
      ],
    );
  }
}
