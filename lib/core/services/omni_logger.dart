import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';

import '../data/objectbox_provider.dart';
import '../models/error_log.dart';
import '../../main.dart'; // برای دسترسی به متغیر سراسری objectbox

class OmniLogger {
  /// متد اصلی برای ثبت خطاها از سراسر برنامه
  static void error({
    required String title,
    required dynamic message,
    StackTrace? stackTrace,
    String? widgetName,
  }) {
    final String errorMsg = message.toString();
    final DateTime now = DateTime.now();

    // ۱. چاپ در کنسول (فقط در حالت Debug)
    log('❌ [$title] در ویجت ($widgetName): $errorMsg');

    // ۲. ذخیره در دیتابیس محلی (ObjectBox)
    _saveToLocalDatabase(
      title: title,
      message: errorMsg,
      stackTrace: stackTrace.toString(),
      widgetName: widgetName ?? 'Global',
      time: now,
    );

    // ۳. ارسال به سیستم‌های آنلاین (مثل Sentry یا Crashlytics)
    _sendToOnlineServices(title, errorMsg, stackTrace, widgetName);
  }

  /// ثبت اطلاعات و وقایع برنامه (بدون ایجاد وقفه یا ثبت به عنوان خطا)
  static void info({
    required String title,
    required String message,
    String? widgetName,
  }) {
    final DateTime now = DateTime.now();
    final bool isDarkMode = Get.isDarkMode;

    // ۱. چاپ در کنسول برای دیباگ (نمایش ساعت، ویجت و پیام)
    log('ℹ️ [$title] | 🕒 ${now.hour}:${now.minute} | 📍 Widget: $widgetName | 📝 $message');

    // ۲. نمایش پیام ملایم به کاربر (UI)
    // استفاده از withValues طبق استاندارد جدید پروژه
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isDarkMode
          ? Colors.white.withValues(alpha: 0.1)
          : Colors.black.withValues(alpha: 0.05),
      colorText: isDarkMode ? Colors.white : Colors.black,
      icon: Icon(Icons.info_outline_rounded,
          color: isDarkMode ? Colors.white : Colors.black // واکنش به تم
          ),
      margin: const EdgeInsets.all(15),
      borderRadius: 15,
      duration: const Duration(seconds: 3),
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: AdaptiveText("متوجه شدم",
            style: TextStyle(color: Colors.cyanAccent, fontSize: 10)),
      ),
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
      final logEntry = ErrorLog(
        title: title,
        message: message,
        stackTrace: stackTrace,
        timestamp: time,
        widgetName: widgetName,
      );
      // استفاده از باکس مخصوص ارورها در ObjectBox
      objectbox.store.box<ErrorLog>().put(logEntry);
    } catch (e) {
      log('Critical: Failed to save error log to ObjectBox: $e');
    }
  }

  static void _sendToOnlineServices(
    String title,
    String message,
    StackTrace? stack,
    String? widget,
  ) {
    // اینجا در آینده کد Sentry یا Firebase را قرار می‌دهیم
    // مثال: Sentry.captureException(message, stackTrace: stack);
  }
}
