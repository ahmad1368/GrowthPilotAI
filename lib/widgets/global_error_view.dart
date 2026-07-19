import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';
// ایمپورت OmniGlassPanel خود را اینجا قرار دهید

class GlobalErrorView extends StatelessWidget {
  final FlutterErrorDetails details;

  const GlobalErrorView({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // استفاده از پس‌زمینه شفاف یا مشابه سایر صفحات برنامه
      backgroundColor: Colors.black.withValues(alpha: 0.1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: OmniGlassPanel(
            // استفاده از پنل استاندارد پروژه
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.system_update_alt_rounded, // یا هر آیکون استاندارد دیگر
                  color: Colors.redAccent,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text(
                  "خطای غیرمنتظره در رابط کاربری",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "متأسفانه در چیدمان این بخش مشکلی پیش آمده است. تیم فنی در حال بررسی خودکار این مورد است.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Get.offAllNamed('/'), // بازگشت ایمن به خانه
                  child: const Text("تلاش مجدد و بازگشت به صفحه اصلی"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
