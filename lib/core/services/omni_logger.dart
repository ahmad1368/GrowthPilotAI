import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/objectbox_provider.dart';
import '../models/error_log.dart';

class OmniLogger {
  static void error({
    required String title,
    required dynamic message,
    StackTrace? stackTrace,
    String? widgetName,
  }) {
    final String errorMsg = message.toString();
    final DateTime now = DateTime.now();

    log('❌ [$title] در ویجت ($widgetName): $errorMsg');

    _saveToLocalDatabase(
      title: title,
      message: errorMsg,
      stackTrace: stackTrace.toString(),
      widgetName: widgetName ?? 'Global',
      time: now,
    );

    _sendToOnlineServices(title, errorMsg, stackTrace, widgetName);
  }

  /// ۲. ثبت هشدارها (زرد/نارنجی - غیر بحرانی)
  static void warning({
    required String title,
    required String message,
    String? widgetName,
  }) {
    final DateTime now = DateTime.now();
    final bool isDarkMode = Get.isDarkMode;

    // چاپ در کنسول با ایموجی هشدار
    log('⚠️ [$title] | 🕒 ${now.hour}:${now.minute} | 📍 Widget: $widgetName | 📝 $message');

    // نمایش اسنک‌بار با تم هشدار (Amber/Orange)
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

  static void info({
    required String title,
    required String message,
    String? widgetName,
  }) {
    final DateTime now = DateTime.now();
    final bool isDarkMode = Get.isDarkMode;

    log('ℹ️ [$title] | 🕒 ${now.hour}:${now.minute} | 📍 Widget: $widgetName | 📝 $message');

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

  static void _saveToLocalDatabase({
    required String title,
    required String message,
    required String stackTrace,
    required String widgetName,
    required DateTime time,
  }) {
    try {
      // راه حل خطا: استفاده از Get.find به جای متغیر سراسری
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
      // بسیار مهم: در اینجا هرگز از FailureMapper استفاده نکنید
      // چون باعث ایجاد چرخه بی‌نهایت (Recursion) می‌شود.
      log('Critical failure: Could not save log to DB: $e');
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
