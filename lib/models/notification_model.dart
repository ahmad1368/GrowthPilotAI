class AppNotification {
  final String title;
  final String message;
  bool isRead;

  AppNotification({
    required this.title, 
    required this.message, 
    this.isRead = false
  });
}