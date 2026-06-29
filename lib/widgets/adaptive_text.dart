import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AdaptiveText(
    this.text, {
    super.key,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // انتخاب استایل پایه بر اساس اینکه آیا استایلی پاس داده شده یا خیر
    final baseStyle = style ?? theme.textTheme.bodyMedium;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle?.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        // اگر رنگ در style مشخص نشده، از رنگ پیش‌فرض تم استفاده کن
        color: style?.color ?? theme.textTheme.bodyLarge?.color,
      ),
    );
  }
}
