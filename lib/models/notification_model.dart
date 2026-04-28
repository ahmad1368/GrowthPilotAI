import 'package:flutter/material.dart';

enum NotificationType { alert, danger, warning, reminder, info }

class AppNotification {
  final String id;
  final String title;
  final String body;
  final String footer;
  final DateTime date;
  final NotificationType type; // نوع نوتیفیکیشن
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.footer,
    required this.date,
    this.type = NotificationType.info,
    this.isRead = false,
  });
}
