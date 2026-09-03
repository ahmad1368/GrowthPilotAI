import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../controllers/ocr_confirmation_controller.dart';

/// Flat action buttons — replaces the former OmniButton with the app's
/// standard ShadButton (solid = primary, .outline = secondary), matching
/// the convention already used throughout lib/features/settings.
class OcrActionButtons extends StatelessWidget {
  final OcrConfirmationController controller;
  const OcrActionButtons({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShadButton(
            onPressed: () async {
              // ۱. ابتدا فانکشن اصلی ذخیره در دیتابیس لوکال صدا زده می‌شود
              final success = await controller.saveTransaction();
              if (success && context.mounted) {
                // ۲. در صورت موفقیت، تابع پاکسازی بامی پشته را صدا می‌زنیم
                _forceCloseOcrWorkflow(context);
              }
            },
            child: const _ButtonContent(
                icon: Icons.check_circle_rounded, label: "تایید و ذخیره"),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ShadButton.outline(
            // دکمه انصراف نیز مستقیماً همان تابع پاکسازی پشته را صدا می‌زند
            onPressed: () => _forceCloseOcrWorkflow(context),
            child:
                const _ButtonContent(icon: Icons.cancel_rounded, label: "انصراف"),
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

class _ButtonContent extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ButtonContent({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
