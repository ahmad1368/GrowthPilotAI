import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/omni_button.dart';
import '../controllers/ocr_confirmation_controller.dart';

class OcrActionButtons extends StatelessWidget {
  final OcrConfirmationController controller;
  const OcrActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OmniButton(
            label: "تایید و ذخیره",
            icon: Icons.check_circle_rounded,
            isPrimary: true,
            onTap: () async {
              // ۱. ابتدا فانکشن اصلی ذخیره در دیتابیس لوکال صدا زده می‌شود
              final success = await controller.saveTransaction();
              if (success && context.mounted) {
                // ۲. در صورت موفقیت، تابع پاکسازی بامی پشته را صدا می‌زنیم
                _forceCloseOcrWorkflow(context);
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OmniButton(
            label: "انصراف",
            icon: Icons.cancel_rounded,
            isPrimary: false,
            // دکمه انصراف نیز مستقیماً همان تابع پاکسازی پشته را صدا می‌زند
            onTap: () => _forceCloseOcrWorkflow(context),
          ),
        ),
      ],
    );
  }

  /// متد نیتیو و تضمینی برای بستن لایه ویرایش و لودینگ‌های پشت سر آن به طور همزمان
  void _forceCloseOcrWorkflow(BuildContext context) {
    int popCount = 0;
    Navigator.popUntil(context, (route) {
      // این شرط تضمین می‌کند که صفحه جاری ویرایش و دیالوگ لودینگ زیرین آن (جمعاً ۲ لایه راوت) بسته شوند
      return popCount++ >= 2 || route.isFirst;
    });
  }
}
