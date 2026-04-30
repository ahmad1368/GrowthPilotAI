import 'dart:ui';
import 'package:flutter/material.dart';

class OmniGlassPanel extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? description;
  final List<Widget>? actionButtons;
  final Widget? footer;
  final bool showCloseButton;
  final double? width;
  final double? height;
  final double opacity;
  final double blurSigma;
  final bool avoidSystemBars;
  final double borderRadius;

  const OmniGlassPanel({
    super.key,
    this.child,
    this.title,
    this.description,
    this.actionButtons,
    this.footer,
    this.showCloseButton = false,
    this.width,
    this.height,
    this.opacity = 0.08,
    this.blurSigma = 15.0,
    this.avoidSystemBars = false,
    this.borderRadius = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.black : Colors.white;
    final onSurfaceColor = isDark ? Colors.white : Colors.black87;

    // استفاده از LayoutBuilder برای مدیریت نمایشگرهای عریض و موبایل
    Widget mainContent = LayoutBuilder(
      builder: (context, constraints) {
        // اگر عرض صفحه بزرگ بود (تبلت/دسکتاپ)، عرض پنل را محدود کن
        double finalWidth =
            width ?? (constraints.maxWidth > 600 ? 500 : double.infinity);

        return Container(
          width: finalWidth,
          height: height,
          padding: const EdgeInsets.all(24),
          child: Column(
            // نکته حیاتی: اگر ارتفاع مشخص نیست، ستون باید به اندازه محتوا جمع شود (min)
            mainAxisSize: height == null ? MainAxisSize.min : MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ۱. هدر
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
                          icon: Icon(Icons.close_rounded,
                              color: onSurfaceColor.withValues(alpha: 0.6)),
                          onPressed: () => Navigator.pop(context),
                        ),
                    ],
                  ),
                ),

// ۲. بدنه - استفاده از Flexible به جای Expanded برای امنیت کامل در Layout
              if (child != null)
                Flexible(
                  fit: height != null ? FlexFit.tight : FlexFit.loose,
                  child: child!,
                )
              else if (description != null)
                Flexible(
                  fit: height != null ? FlexFit.tight : FlexFit.loose,
                  child: _buildDescription(onSurfaceColor),
                ),
              // ۳. پانویس و دکمه‌ها
              if (actionButtons != null || footer != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // جلوگیری از اشغال فضای اضافی
                    children: [
                      Divider(
                          color: onSurfaceColor.withValues(alpha: 0.1),
                          height: 1),
                      const SizedBox(height: 20),
                      if (actionButtons != null)
                        Wrap(
                          // استفاده از Wrap برای جلوگیری از Overflow در موبایل‌های کوچک
                          alignment: WrapAlignment.end,
                          spacing: 12,
                          runSpacing: 10,
                          children: actionButtons!,
                        ),
                      if (footer != null) footer!,
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );

    if (avoidSystemBars) {
      mainContent = SafeArea(child: mainContent);
    }

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          decoration: BoxDecoration(
            color: baseColor.withValues(alpha: opacity),
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius)),
            border: Border.all(
              color: onSurfaceColor.withValues(alpha: 0.15),
              width: 0.5,
            ),
          ),
          child: mainContent,
        ),
      ),
    );
  }

  Widget _buildDescription(Color color) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Text(
        description!,
        style: TextStyle(
          fontSize: 16,
          height: 1.7,
          color: color.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
