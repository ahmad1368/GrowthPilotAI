import 'package:flutter/material.dart';
import 'dart:ui';
import 'adaptive_text.dart';

class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double opacity;
  final List<Widget>? actions;

  const GlassAppBar({
    super.key,
    required this.title,
    required this.opacity,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: AppBar(
          elevation: 0,
          backgroundColor: (isDark ? Colors.black : Colors.white).withOpacity(opacity * 0.7),
          title: AdaptiveText(title, fontWeight: FontWeight.bold),
          actions: actions,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}