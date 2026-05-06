import 'dart:ui';
import 'package:flutter/material.dart';
// اضافه کردن این خط برای رفع خطای RendererBinding

class OmniGlassPanel extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? child;
  final List<Widget>? actionButtons;
  final Widget? footer;
  final double? width;
  final double? height;
  final double opacity;
  final double borderRadius;
  final double blurSigma;
  final bool showCloseButton;
  final bool avoidSystemBars;
  final bool isInteractive;
  final bool fullBorderRadius;
  final IconData? leadingIcon;

  const OmniGlassPanel({
    super.key,
    this.title,
    this.description,
    this.child,
    this.actionButtons,
    this.footer,
    this.width,
    this.height,
    this.opacity = 0.2,
    this.borderRadius = 24.0,
    this.blurSigma = 15.0,
    this.showCloseButton = false,
    this.avoidSystemBars = true,
    this.isInteractive = false,
    this.fullBorderRadius = false,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // استفاده از تم پروژه برای هماهنگی بیشتر
    final baseColor = isDark ? Colors.black : Colors.white;
    final onSurfaceColor = isDark ? Colors.white : Colors.black87;

    final borderStyle = fullBorderRadius
        ? BorderRadius.circular(borderRadius)
        : BorderRadius.vertical(top: Radius.circular(borderRadius));

    bool localHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          cursor: isInteractive
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onEnter: (_) {
            if (isInteractive) setState(() => localHovered = true);
          },
          onExit: (_) {
            if (isInteractive) setState(() => localHovered = false);
          },
          child: AnimatedScale(
            scale: (isInteractive && localHovered) ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: borderStyle,
                boxShadow: (isInteractive && localHovered)
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ]
                    : [],
              ),
              child: ClipRRect(
                borderRadius:
                    borderStyle, // حتماً باید با BoxDecoration هماهنگ باشد
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: baseColor.withValues(
                        alpha: (isInteractive && localHovered)
                            ? opacity + 0.1
                            : opacity,
                      ),
                      borderRadius: borderStyle,
                      border: Border.all(
                        color: (isInteractive && localHovered)
                            ? theme.colorScheme.primary.withValues(alpha: 0.5)
                            : onSurfaceColor.withValues(alpha: 0.1),
                        width: (isInteractive && localHovered) ? 1.5 : 0.8,
                      ),
                    ),
                    child: _buildContent(context, onSurfaceColor),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // متد کمکی برای ساختار داخلی (بدون تغییر در منطق شما)
  Widget _buildContent(BuildContext context, Color onSurfaceColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double finalWidth =
            width ?? (constraints.maxWidth > 600 ? 500 : double.infinity);

        Widget body = Container(
          width: finalWidth,
          height: height,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: height == null ? MainAxisSize.min : MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null || showCloseButton)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      // --- اضافه کردن بخش Leading Icon با استایل هماهنگ ---
                      if (leadingIcon != null) ...[
                        Icon(
                          leadingIcon,
                          color: onSurfaceColor.withValues(
                              alpha: 0.8), // هماهنگی با تم روشن/تاریک
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                      ],
                      // ------------------------------------------------
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: onSurfaceColor.withValues(alpha: 0.9),
                                ),
                          ),
                        ),
                      if (showCloseButton)
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.pop(context),
                          color: onSurfaceColor.withValues(alpha: 0.5),
                        ),
                    ],
                  ),
                ),
              if (child != null)
                Flexible(
                  fit: height != null ? FlexFit.tight : FlexFit.loose,
                  child: child!,
                )
              else if (description != null)
                Flexible(
                  fit: height != null ? FlexFit.tight : FlexFit.loose,
                  child: Text(
                    description!,
                    style: TextStyle(
                      color: onSurfaceColor.withValues(alpha: 0.7),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                ),
              if (actionButtons != null || footer != null)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                          color: onSurfaceColor.withValues(alpha: 0.05),
                          height: 1),
                      const SizedBox(height: 20),
                      if (actionButtons != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: actionButtons!,
                          ),
                        ),
                      if (footer != null) footer!,
                    ],
                  ),
                ),
            ],
          ),
        );

        return avoidSystemBars ? SafeArea(child: body) : body;
      },
    );
  }
}
