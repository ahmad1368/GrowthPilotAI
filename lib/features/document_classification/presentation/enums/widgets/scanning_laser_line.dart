// lib/features/document_classification/presentation/widgets/scanning_laser_line.dart
import 'package:flutter/material.dart';

class ScanningLaserLine extends StatefulWidget {
  const ScanningLaserLine({super.key});

  @override
  State<ScanningLaserLine> createState() => _ScanningLaserLineState();
}

class _ScanningLaserLineState extends State<ScanningLaserLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: LaserPainter(_controller.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class LaserPainter extends CustomPainter {
  final double progress;
  LaserPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.cyanAccent.withValues(alpha: 0.0),
          Colors.cyanAccent.withValues(alpha: 0.8),
          Colors.cyanAccent.withValues(alpha: 0.0),
        ],
      ).createShader(
          Rect.fromLTWH(0, size.height * progress - 10, size.width, 20));

    canvas.drawRect(
        Rect.fromLTWH(0, size.height * progress - 2, size.width, 4), paint);
  }

  @override
  bool shouldRepaint(covariant LaserPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
