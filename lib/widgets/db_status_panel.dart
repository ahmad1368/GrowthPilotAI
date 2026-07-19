import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'omni_glass_panel.dart';

class DbStatusPanel extends StatelessWidget {
  const DbStatusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // استفاده از UIHelper برای حفظ یکپارچگی در کل اپلیکیشن
    final bool isWide = UIHelper.isWide(context);

    return OmniGlassPanel(
      title: "Database Engine",
      isInteractive: true,
      fullBorderRadius: true,
      // عرض داینامیک بر اساس استاندارد پروژه
      width: UIHelper.getAdaptiveWidth(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading:
                const Icon(Icons.sd_storage_rounded, color: Colors.blueAccent),
            title: const AdaptiveText("ObjectBox SDK",
                fontWeight: FontWeight.bold),
            subtitle: const AdaptiveText(
              // [Issue #16] این استور رمزنگاری در سطح فیلد/دیسک ندارد؛ نسخه
              // رایگان ObjectBox از پارامتر password پشتیبانی نمی‌کند. تا
              // پیاده‌سازی واقعی رمزنگاری، ادعای اشتباه "Secured with
              // AES-256" حذف شد تا کاربر را گمراه نکند.
              "Status: Not encrypted at rest (Community edition)",
              fontSize: 12,
            ),
            trailing: Icon(
              Icons.lock_open_rounded,
              color: Colors.orangeAccent.withValues(alpha: 0.8),
            ),
          ),
          const Divider(color: Colors.white10, height: 20),

          // مدیریت چیدمان دکمه‌ها بر اساس نوع نمایشگر
          isWide ? _buildWideActions() : _buildMobileActions(),
        ],
      ),
    );
  }

  Widget _buildWideActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {},
            child: const AdaptiveText("View Schema", fontSize: 13)),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
          ),
          child: const AdaptiveText("Sync Store", fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildMobileActions() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.storage_rounded, size: 18),
        onPressed: () {},
        label: const AdaptiveText("Compact Store"),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
