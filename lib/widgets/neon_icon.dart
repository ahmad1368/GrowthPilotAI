import 'package:flutter/material.dart';

class NeonIcon extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final double blurRadius;
  final double? opacity;
  final bool isAnimated;

  const NeonIcon({
    super.key,
    required this.icon,
    this.size = 28.0,
    this.color,
    this.blurRadius = 15.0,
    this.opacity,
    this.isAnimated = false,
  });

  @override
  State<NeonIcon> createState() => _NeonIconState();
}

class _NeonIconState extends State<NeonIcon> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    final themeColor = widget.color ?? Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // منطق اولویت‌بندی شفافیت
    final double effectiveAlpha = widget.opacity ?? (isDark ? 0.8 : 0.3);

    // مقادیر مربوط به انیمیشن
    final double yOffset = (widget.isAnimated && _isActive) ? -6.0 : 0.0;
    final double scale = (widget.isAnimated && _isActive) ? 1.2 : 1.0;

    return MouseRegion(
      // مدیریت وضعیت در وب و دسکتاپ
      onEnter: (_) => setState(() => _isActive = true),
      onExit: (_) => setState(() => _isActive = false),
      child: GestureDetector(
        // مدیریت وضعیت در موبایل (لمس کردن)
        onPanDown: (_) => setState(() => _isActive = true),
        onPanCancel: () => setState(() => _isActive = false),
        onPanEnd: (_) => setState(() => _isActive = false),
        onTapDown: (_) => setState(() => _isActive = true),
        onTapUp: (_) => setState(() => _isActive = false),
        
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          transform: Matrix4.identity()
            ..translate(0.0, yOffset)
            ..scale(scale),
          child: Icon(
            widget.icon,
            size: widget.size,
            color: themeColor,
            shadows: [
              // لایه اول: درخشش اصلی
              Shadow(
                color: themeColor.withValues(alpha: effectiveAlpha),
                blurRadius: isDark ? widget.blurRadius : widget.blurRadius / 3,
              ),
              // لایه دوم: عمق نئونی (در حالت دارک یا تنظیم دستی)
              if (isDark || widget.opacity != null)
                Shadow(
                  color: themeColor.withValues(
                      alpha: (effectiveAlpha * 0.6).clamp(0.0, 1.0)),
                  blurRadius: widget.blurRadius * 2,
                ),
              // لایه سوم: حفظ وضوح لبه‌ها
              Shadow(
                color: themeColor.withValues(alpha: 0.4),
                blurRadius: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}