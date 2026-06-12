import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/presentation/widgets/app_drawer_header.dart';
import 'package:growth_pilot_ai/core/presentation/widgets/app_drawer_menu.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = UIHelper.isWide(context)
        ? 320.0
        : MediaQuery.of(context).size.width * 0.8;

    return Drawer(
      elevation: 0,
      width: width,
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const AppDrawerHeader(),
              const Divider(color: Colors.white10, height: 30),
              const Expanded(child: AppDrawerMenu()),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "GrowthPilot AI v1.0.8",
                  // 💡 استفاده از تم نیتیو فلاتر جهت جلوگیری از تداخل کانتکست و کرش‌های احتمالی
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.white24 : Colors.black26,
                            fontWeight: FontWeight.w400,
                          ) ??
                      const TextStyle(color: Colors.white24, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
