// lib/core/errors/failure_mapper.dart

import 'dart:io';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart'; // مسیر را چک کن

class FailureMapper {
  static OmniResponse<T> map<T>(Object error, {StackTrace? stack}) {
    // اصلاح فراخوانی لاگر بر اساس پارامترهایی که با هم ست کردیم
    OmniLogger.error(
      title: "Exception Captured in Mapper",
      widgetName: "FailureMapper",
      message: error, // تغییر نام از error به message بر اساس پیام خطا
      stackTrace: stack, // تغییر نام احتمالی از stack به stackTrace
    );

    if (error is FileSystemException) {
      return OmniResponse.error("خطا در دسترسی به فایل.");
    }

    // اضافه کردن تشخیص خطاهای دیتابیس (اختیاری اما مفید)
    if (error.toString().contains("ObjectBoxException")) {
      return OmniResponse.error("خطا در عملیات دیتابیس محلی.");
    }

    return OmniResponse.error("خطای ناشناخته: ${error.toString()}");
  }
}
