import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';

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
  final Color? backgroundColor;

  const OmniGlassPanel({
    super.key,
    this.title,
    this.description,
    this.child,
    this.actionButtons,
    this.footer,
    this.width,
    this.height,
    this.opacity = 0.1,
    this.borderRadius = 24.0,
    this.blurSigma = 15.0,
    this.showCloseButton = false,
    this.avoidSystemBars = true,
    this.isInteractive = false,
    this.fullBorderRadius = true,
    this.leadingIcon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurfaceColor = isDark ? Colors.white : Colors.black87;

    // رعایت استاندارد رنگ آیکون‌ها بر اساس تم
    final iconColor = isDark ? Colors.white : Colors.black;

    final borderStyle = fullBorderRadius
        ? BorderRadius.circular(borderRadius)
        : BorderRadius.vertical(top: Radius.circular(borderRadius));

    return ClipRRect(
      borderRadius: borderStyle,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: _buildDecoration(isDark, borderStyle, theme),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(iconColor),
              // بخش حیاتی برای رفع خطای Overflow و فعال‌سازی دکمه‌ها
              Flexible(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: _buildContent(context, onSurfaceColor),
                ),
              ),
              if (actionButtons != null) _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color iconColor) {
    if (title == null && leadingIcon == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, color: iconColor, size: 22),
            const SizedBox(width: 12),
          ],
          if (title != null)
            Expanded(
              child: AdaptiveText(
                title!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: iconColor, // هماهنگ با تم
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(16),
      // Wrap باعث می‌شود در نمایشگرهای کوچک دکمه‌ها زیر هم و در بزرگ کنار هم باشند
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.end,
        children: actionButtons!.map((button) {
          // محدود کردن عرض دکمه در مانیتورهای بزرگ برای زیبایی بیشتر
          return ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 100),
            child: button,
          );
        }).toList(),
      ),
    );
  }

  BoxDecoration _buildDecoration(
      bool isDark, BorderRadius radius, ThemeData theme) {
    final baseColor = isDark ? Colors.black : const Color(0xFFF7F8FA);
    return BoxDecoration(
      color: baseColor.withValues(alpha: isDark ? 0.2 : 0.85),
      borderRadius: radius,
      border: Border.all(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.1),
        width: 0.8,
      ),
    );
  }

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
                      if (leadingIcon != null) ...[
                        Icon(leadingIcon,
                            color: onSurfaceColor.withValues(alpha: 0.8),
                            size: 24),
                        const SizedBox(width: 12),
                      ],
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
                          alignment: Alignment.centerLeft,
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
