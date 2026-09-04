import 'package:flutter/material.dart';

/// [Issue #784] Paints a low-opacity, brick-offset tile of domain icons —
/// WhatsApp-doodle-style, but receipts/growth/finance themed. Glyphs are
/// painted directly from [IconData] (no image/SVG asset), so this stays a
/// pure-Dart, offline-safe, lightweight background.
class BackgroundPatternPainter extends CustomPainter {
  final Color color;
  BackgroundPatternPainter({required this.color});

  static const _icons = [
    Icons.receipt_long_rounded,
    Icons.trending_up_rounded,
    Icons.account_balance_wallet_rounded,
    Icons.description_rounded,
    Icons.query_stats_rounded,
  ];

  static const double _tile = 96;
  static const double _glyphSize = 28;

  @override
  void paint(Canvas canvas, Size size) {
    var iconIndex = 0;
    var row = 0;
    for (double y = -_tile / 2; y < size.height + _tile; y += _tile) {
      // آفست ردیف‌های زوج/فرد برای الگوی آجری کمتر شبکه‌ای
      final rowOffset = row.isEven ? 0.0 : _tile / 2;
      for (double x = -_tile / 2 + rowOffset; x < size.width + _tile; x += _tile) {
        _paintGlyph(canvas, Offset(x, y), _icons[iconIndex % _icons.length]);
        iconIndex++;
      }
      row++;
    }
  }

  void _paintGlyph(Canvas canvas, Offset center, IconData icon) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: _glyphSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
        canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant BackgroundPatternPainter oldDelegate) =>
      oldDelegate.color != color;
}
