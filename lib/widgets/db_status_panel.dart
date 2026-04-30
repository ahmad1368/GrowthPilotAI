import 'package:flutter/material.dart';
import 'omni_glass_panel.dart';

class DbStatusPanel extends StatelessWidget {
  const DbStatusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // تشخیص نمایشگر عریض (بیشتر از 600 پیکسل)
        bool isWide = constraints.maxWidth > 600;

        return OmniGlassPanel(
          title: "Database Engine",
          isInteractive: true,
          fullBorderRadius: true,
          // تنظیم عرض داینامیک: در دسکتاپ 400 واحد، در موبایل تمام صفحه
          width: isWide ? 400 : double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                // اصلاح نام آیکون به حروف کوچک و حذف const از ابتدای آیکون
                // چون Colors.blueAccent یک مقدار داینامیک است
                leading:
                    Icon(Icons.sd_storage_rounded, color: Colors.blueAccent),
                title: const Text("ObjectBox SDK"),
                subtitle: const Text("Status: Integrated & Ready"),
                trailing: Icon(Icons.check_circle_outline_rounded,
                    color: Colors.green[400]),
              ),
              const Divider(color: Colors.white10),
              // نمایشگر عریض دکمه‌ها را در کنار هم و موبایل زیر هم نشان می‌دهد
              isWide ? _buildWideActions() : _buildMobileActions(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWideActions() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: null, child: Text("View Schema")),
        SizedBox(width: 8),
        ElevatedButton(onPressed: null, child: Text("Run Generator")),
      ],
    );
  }

  Widget _buildMobileActions() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.build_circle_outlined),
        onPressed: null,
        label: const Text("Initialize ObjectBox Store"),
      ),
    );
  }
}
