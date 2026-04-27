import 'package:flutter/material.dart';

class AdaptiveText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextStyle? style; // پارامتر جدید برای استایل سفارشی

  const AdaptiveText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // ۱. استایل پیش‌فرض که به شب و روز واکنش نشان می‌دهد
    final defaultStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
    );

    return Text(
      text,
      textAlign: textAlign,
      // ۲. ترکیب استایل پیش‌فرض با استایل سفارشی (اگر وجود داشته باشد)
      // متد merge باعث می‌شود مقادیر style بر مقادیر defaultStyle اولویت پیدا کنند
      style: style != null ? defaultStyle.merge(style) : defaultStyle,
    );
  }
}