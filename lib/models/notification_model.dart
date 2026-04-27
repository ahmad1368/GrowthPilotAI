class AppNotification {
  final String id;
  final String title;
  final String body;
  final String footer;
  final DateTime date;
  bool isRead;

  AppNotification({
    required this.id,      // حتماً کلمه required قبل از this.id باشد
    required this.title,
    required this.body,
    required this.footer,
    required this.date,
    this.isRead = false,
  });
}