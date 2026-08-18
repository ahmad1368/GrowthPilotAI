import 'package:growth_pilot_ai/core/enum/canvas_save_status.dart';

/// "Warn the user if they try to leave the screen while a Save
/// operation is still pending" (Issue #222's implementation note).
class ShouldWarnBeforeLeavingCanvas {
  static bool call(CanvasSaveStatus status) => status == CanvasSaveStatus.saving;
}
