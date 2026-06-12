import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class WebOfflineOverlay extends StatelessWidget {
  const WebOfflineOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ShadTheme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded,
                  color: Color(0xffef4444), size: 48),
              const SizedBox(height: 16),
              Text("عدم اتصال به شبکه",
                  style: ShadTheme.of(context).textTheme.h3),
              const SizedBox(height: 8),
              Text(
                "اتصال اینترنت شما برقرار نیست. لطفاً وضعیت شبکه خود را بررسی کنید.",
                textAlign: TextAlign.center,
                style: ShadTheme.of(context).textTheme.p.copyWith(
                      color: fgColor.withValues(alpha: 0.6),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
