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
    final iconColor = isDark ? Colors.white : Colors.black;

    final borderStyle = fullBorderRadius
        ? BorderRadius.circular(borderRadius)
        : BorderRadius.vertical(top: Radius.circular(borderRadius));

    return LayoutBuilder(
      builder: (context, constraints) {
        // محاسبه عرض هوشمند برای تبلت و دسکتاپ
        double finalWidth =
            width ?? (constraints.maxWidth > 600 ? 500 : double.infinity);

        Widget panelBody = ClipRRect(
          borderRadius: borderStyle,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              width: finalWidth,
              height: height,
              decoration: _buildDecoration(isDark, borderStyle, theme),
              child: Column(
                mainAxisSize:
                    height == null ? MainAxisSize.min : MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(iconColor, context),

                  // محتوای اصلی پویا با اسکرول ایمن
                  Flexible(
                    fit: height != null ? FlexFit.tight : FlexFit.loose,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      child: _buildContent(onSurfaceColor),
                    ),
                  ),

                  if (actionButtons != null || footer != null)
                    _buildFooter(onSurfaceColor),
                ],
              ),
            ),
          ),
        );

        return avoidSystemBars ? SafeArea(child: panelBody) : panelBody;
      },
    );
  }

  Widget _buildHeader(Color iconColor, BuildContext context) {
    if (title == null && leadingIcon == null && !showCloseButton) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Row(
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon,
                color: iconColor.withValues(alpha: 0.9), size: 24),
            const SizedBox(width: 12),
          ],
          if (title != null)
            Expanded(
              child: AdaptiveText(
                title!,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: iconColor.withValues(alpha: 0.9),
                    ),
              ),
            ),
          if (showCloseButton)
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.close_rounded),
              onPressed: () => Navigator.pop(context),
              color: iconColor.withValues(alpha: 0.5),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(Color onSurfaceColor) {
    if (child != null) return child!;

    if (description != null) {
      return AdaptiveText(
        description!,
        style: TextStyle(
          color: onSurfaceColor.withValues(alpha: 0.7),
          fontSize: 15,
          height: 1.6,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildFooter(Color onSurfaceColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            color: onSurfaceColor.withValues(alpha: 0.08),
            height: 1,
          ),
          const SizedBox(height: 20),
          if (actionButtons != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.end,
                children: actionButtons!.map((button) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 100),
                    child: button,
                  );
                }).toList(),
              ),
            ),
          if (footer != null) ...[
            const SizedBox(height: 12),
            footer!,
          ],
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration(
      bool isDark, BorderRadius radius, ThemeData theme) {
    final baseColor = isDark ? Colors.black : const Color(0xFFF7F8FA);
    return BoxDecoration(
      color:
          backgroundColor ?? baseColor.withValues(alpha: isDark ? 0.2 : 0.85),
      borderRadius: radius,
      border: Border.all(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.1),
        width: 0.8,
      ),
    );
  }
}
