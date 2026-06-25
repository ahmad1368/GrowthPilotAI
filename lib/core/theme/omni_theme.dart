import 'package:flutter/material.dart';

class OmniTheme {
  // رنگ لایت‌مد اختصاصی که تایید کردید
  static const Color lightBgColor = Color(0xFFF7F8FA);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBgColor,
      // کلید حل مشکل شما: تنظیم تم سراسری آیکون‌ها
      iconTheme: const IconThemeData(
        color: Colors.black, // تمام آیکون‌ها در لایت‌مد مشکی می‌شوند
        size: 24,
      ),
      // تنظیم رنگ آیکون‌های داخل AppBar به صورت مجزا
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      iconTheme: const IconThemeData(
        color: Colors.white, // تمام آیکون‌ها در دارک‌مد سفید می‌شوند
        size: 24,
      ),
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
