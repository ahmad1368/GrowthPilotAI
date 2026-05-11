import 'package:growth_pilot_ai/objectbox.g.dart';

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
