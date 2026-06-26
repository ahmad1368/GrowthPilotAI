import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../data/objectbox_provider.dart';
import '../models/error_log.dart';

enum LogBottleneck {
  database, // ObjectBox IO
  aiOcr, // TFLite / AI Pipeline
  network, // API Calls
  security, // Security Filters
  business, // Controllers & Bloc
  global // پیش‌فرض برای کدهای قدیمی پروژه
}

class OmniLogger {
  // تعریف پکیج Logger برای ساخت کادرهای زیبا و رنگی در کنسول
  static final Logger _prettyLogger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 90,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  /// ۱. ثبت خطاهای بحرانی (بدون شکستن فراخوانی‌های قبلی)
  static void error({
    required String title,
    required dynamic message,
    StackTrace? stackTrace,
    String? widgetName,
    LogBottleneck bottleneck = LogBottleneck.global, // پارامتر اختیاری جدید
  }) {
    final String errorMsg = message.toString();
    final DateTime now = DateTime.now();

    // استفاده از لاگر پیشرفته برای نمایش رنگی و ساختاریافته در کنسول
    _prettyLogger.e(
      '[$bottleneck] [$title] در ویجت (${widgetName ?? 'Global'}): $errorMsg',
      error: message,
      stackTrace: stackTrace,
    );

    // ذخیره در دیتابیس لوکال (کد قبلی شما)
    _saveToLocalDatabase(
      title: title,
      message: errorMsg,
      stackTrace: stackTrace.toString(),
      widgetName: widgetName ?? 'Global',
      time: now,
    );

    _sendToOnlineServices(title, errorMsg, stackTrace, widgetName);
  }

  /// ۲. ثبت هشدارها و نمایش اسنک‌بار (بدون شکستن فراخوانی‌های قبلی)
  static void warning({
    required String title,
    required String message,
    String? widgetName,
    LogBottleneck bottleneck = LogBottleneck.global, // پارامتر اختیاری جدید
  }) {
    final DateTime now = DateTime.now();
    final bool isDarkMode = Get.isDarkMode;

    // لاگ رنگی هشدار در کنسول
    _prettyLogger
        .w('[$bottleneck] [$title] | 📍 Widget: $widgetName | 📝 $message');

    // نمایش اسنک‌بار با تم هشدار (کد قبلی شما)
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDarkMode
          ? Colors.amber.withValues(alpha: 0.2)
          : Colors.orange.withValues(alpha: 0.1),
      colorText: isDarkMode ? Colors.amber[100] : Colors.orange[900],
      icon: Icon(
        Icons.warning_amber_rounded,
        color: isDarkMode ? Colors.amberAccent : Colors.orangeAccent,
      ),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 4),
      borderWidth: 1,
      borderColor: isDarkMode
          ? Colors.amber.withValues(alpha: 0.3)
          : Colors.orange.withValues(alpha: 0.2),
    );
  }

  /// ۳. ثبت لاگ‌های اطلاعاتی و نمایش اسنک‌بار (بدون شکستن فراخوانی‌های قبلی)
  static void info({
    required String title,
    required String message,
    String? widgetName,
    LogBottleneck bottleneck = LogBottleneck.global, // پارامتر اختیاری جدید
  }) {
    final bool isDarkMode = Get.isDarkMode;

    // لاگ رنگی اطلاعات در کنسول
    _prettyLogger
        .i('[$bottleneck] [$title] | 📍 Widget: $widgetName | 📝 $message');

    // نمایش اسنک‌بار اطلاعاتی (کد قبلی شما)
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDarkMode
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.black.withValues(alpha: 0.05),
      colorText: isDarkMode ? Colors.white : Colors.black,
      icon: Icon(Icons.info_outline_rounded,
          color: isDarkMode ? Colors.white : Colors.black),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
    );
  }

  /// ۴. متد کاملاً جدید برای مانیتورینگ سرعت و عملکرد گلوگاه‌ها (Performance Tracking)
  static void traceTime({
    required LogBottleneck bottleneck,
    required String operation,
    required Duration duration,
  }) {
    _prettyLogger.t(
        '[$bottleneck] ⏱️ Execution Time for "$operation": ${duration.inMilliseconds}ms');
  }

  /// متدهای خصوصی مربوط به دیتابیس لوکال و سرور (بدون تغییر)
  static void _saveToLocalDatabase({
    required String title,
    required String message,
    required String stackTrace,
    required String widgetName,
    required DateTime time,
  }) {
    try {
      if (Get.isRegistered<ObjectBox>()) {
        final objectBoxInstance = Get.find<ObjectBox>();

        final logEntry = ErrorLog(
          title: title,
          message: message,
          stackTrace: stackTrace,
          timestamp: time,
          widgetName: widgetName,
        );

        objectBoxInstance.store.box<ErrorLog>().put(logEntry);
      }
    } catch (e) {
      dev.log('Critical failure: Could not save log to DB: $e');
    }
  }

  static void _sendToOnlineServices(
    String title,
    String message,
    StackTrace? stack,
    String? widget,
  ) {
    // برای آینده
  }
}
