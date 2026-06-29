import 'package:objectbox/objectbox.dart'; // <--- این خط باید حتماً باشد

@Entity()
class ErrorLog {
  @Id()
  int id = 0;

  String title;
  String message;
  String stackTrace;
  DateTime timestamp;
  String widgetName;

  ErrorLog({
    required this.title,
    required this.message,
    this.stackTrace = '',
    required this.timestamp,
    this.widgetName = 'Unknown',
  });
}
