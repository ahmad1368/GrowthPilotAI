class AppNotification {
  final int id;
  final String title;
  final String message;
  final String date;
  final String time;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.time,
    this.isRead = false,
  });
}
