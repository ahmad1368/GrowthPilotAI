import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // اضافه کردن این خط برای رفع خطای RendererBinding

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
  final bool isInteractive; // قابلیت جدید: واکنش به حرکت موس
  final bool fullBorderRadius; // قابلیت جدید: گرد کردن هر ۴ گوشه

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
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[900]! : Colors.white;
    final onSurfaceColor = isDark ? Colors.white : Colors.black87;

    final borderStyle = fullBorderRadius
        ? BorderRadius.circular(borderRadius)
        : BorderRadius.vertical(top: Radius.circular(borderRadius));

    // یک متغیر برای نگه داشتن وضعیت هوور بصورت محلی
    bool localHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) {
            if (isInteractive) setState(() => localHovered = true);
          },
          onExit: (_) {
            if (isInteractive) setState(() => localHovered = false);
          },
          child: AnimatedScale(
            scale: (isInteractive && localHovered)
                ? 1.03
                : 1.0, // کمی بزرگتر برای ملموس بودن
            duration: const Duration(milliseconds: 200),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: borderStyle,
                boxShadow: (isInteractive && localHovered)
                    ? [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 30,
                          spreadRadius: 2,
                        )
                      ]
                    : [],
              ),
              child: ClipRRect(
                borderRadius: borderStyle,
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                  child: Container(
                    decoration: BoxDecoration(
                      color: baseColor.withValues(
                        alpha: (isInteractive && localHovered)
                            ? opacity + 0.1
                            : opacity,
                      ),
                      borderRadius: borderStyle,
                      border: Border.all(
                        color: (isInteractive && localHovered)
                            ? theme.colorScheme.primary.withValues(alpha: 0.6)
                            : onSurfaceColor.withValues(alpha: 0.1),
                        width: (isInteractive && localHovered) ? 1.5 : 0.5,
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

  Widget _buildContent(BuildContext context, Color onSurfaceColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // مدیریت عرض برای نمایشگرهای عریض
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
              // --- هدر پنل (عنوان و دکمه بستن) ---
              if (title != null || showCloseButton)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      if (title != null)
                        Expanded(
                          child: Text(
                            title!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: onSurfaceColor.withValues(alpha: 0.9),
                                ),
                          ),
                        ),
                      if (showCloseButton)
                        IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => Navigator.pop(context),
                          color: onSurfaceColor.withValues(alpha: 0.5),
                        ),
                    ],
                  ),
                ),

              // --- بخش بدنه اصلی ---
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
                      height: 1.5,
                    ),
                  ),
                ),

              // --- بخش دکمه‌های عملیاتی و فوتر ---
              if (actionButtons != null || footer != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                          color: onSurfaceColor.withValues(alpha: 0.1),
                          height: 1),
                      const SizedBox(height: 20),
                      if (actionButtons != null)
                        Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 12,
                          runSpacing: 12,
                          children: actionButtons!,
                        ),
                      if (footer != null) footer!,
                    ],
                  ),
                ),
            ],
          ),
        );

        // اعمال SafeArea اگر درخواست شده بود
        return avoidSystemBars ? SafeArea(child: body) : body;
      },
    );
  }
}
