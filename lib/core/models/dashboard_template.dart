import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// An "Expert Blueprint" archetype (Issue #118): a named, pre-defined
/// [layout] the user can one-tap apply to instantly reorganize the Gridded
/// Canvas (#113) for a specific goal.
@immutable
class DashboardTemplate {
  final String id;
  final String name;
  final String description;
  final List<WidgetLayout> layout;

  const DashboardTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.layout,
  });
}
