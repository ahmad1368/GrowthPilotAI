import 'package:flutter/foundation.dart';

/// A report widget's position and "Positioning Intelligence" (Issue #114):
/// [isLocked] widgets (critical system alerts) can never be user-dragged
/// and always float to the front, regardless of the saved order.
@immutable
class WidgetLayout {
  final String widgetId;
  final int position;
  final int crossAxisSpan;
  final bool isLocked;

  const WidgetLayout({
    required this.widgetId,
    required this.position,
    this.crossAxisSpan = 1,
    this.isLocked = false,
  });

  WidgetLayout copyWith({int? position}) => WidgetLayout(
        widgetId: widgetId,
        position: position ?? this.position,
        crossAxisSpan: crossAxisSpan,
        isLocked: isLocked,
      );

  Map<String, dynamic> toJson() => {
        'widgetId': widgetId,
        'position': position,
        'crossAxisSpan': crossAxisSpan,
        'isLocked': isLocked,
      };

  static WidgetLayout fromJson(Map<String, dynamic> json) => WidgetLayout(
        widgetId: json['widgetId'] as String,
        position: json['position'] as int,
        crossAxisSpan: json['crossAxisSpan'] as int? ?? 1,
        isLocked: json['isLocked'] as bool? ?? false,
      );
}
