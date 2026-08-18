import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_warn_before_leaving_canvas.dart';
import 'package:growth_pilot_ai/core/enum/canvas_save_status.dart';

void main() {
  group('ShouldWarnBeforeLeavingCanvas', () {
    test('true while saving', () {
      expect(ShouldWarnBeforeLeavingCanvas.call(CanvasSaveStatus.saving), isTrue);
    });

    test('false when idle or saved', () {
      expect(ShouldWarnBeforeLeavingCanvas.call(CanvasSaveStatus.idle), isFalse);
      expect(ShouldWarnBeforeLeavingCanvas.call(CanvasSaveStatus.saved), isFalse);
    });
  });
}
