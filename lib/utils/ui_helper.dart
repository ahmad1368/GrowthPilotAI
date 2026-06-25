import 'package:flutter/material.dart';

class UIHelper {
  // حد مرز برای تشخیص نمایشگر عریض (Breakpoint)
  static const double kTabletBreakpoint = 600.0;

  // حداکثر عرض مجاز برای پنل‌ها در نمایشگرهای بزرگ
  static const double kMaxContentWidth = 450.0;

  /// تشخیص اینکه آیا نمایشگر عریض است یا خیر
  static bool isWide(BuildContext context) {
    return MediaQuery.of(context).size.width >= kTabletBreakpoint;
  }

  /// برگرداندن عرض داینامیک:
  /// اگر عریض باشد، یک مقدار ثابت (Max Width) و اگر موبایل باشد، تمام صفحه
  static double getAdaptiveWidth(BuildContext context) {
    return isWide(context) ? kMaxContentWidth : double.infinity;
  }

  /// دریافت عرض کل صفحه برای محاسبات خاص
  static double deviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
