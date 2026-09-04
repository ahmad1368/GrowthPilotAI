import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/theme/background_pattern_painter.dart';

/// Covers Issue #784's background pattern painter's repaint contract.
void main() {
  group('BackgroundPatternPainter.shouldRepaint', () {
    test('is false when the color is unchanged', () {
      final a = BackgroundPatternPainter(color: Colors.orange);
      final b = BackgroundPatternPainter(color: Colors.orange);

      expect(a.shouldRepaint(b), isFalse);
    });

    test('is true when the color changes (e.g. a theme switch)', () {
      final a = BackgroundPatternPainter(color: Colors.orange);
      final b = BackgroundPatternPainter(color: Colors.deepOrange);

      expect(a.shouldRepaint(b), isTrue);
    });
  });
}
