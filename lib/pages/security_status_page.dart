import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart'; // اضافه شد
import '../widgets/omni_glass_panel.dart';
import '../widgets/adaptive_text.dart';
import 'insight_page.dart';

class SecurityStatusPage extends StatefulWidget {
  const SecurityStatusPage({super.key});

  @override
  State<SecurityStatusPage> createState() => _SecurityStatusPageState();
}

class _SecurityStatusPageState extends State<SecurityStatusPage> {
  // تعریف اسکرول کنترلر برای رفع خطای InsightPage
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // نکته: InsightPage فعلاً لیست داخلی خودش را نشان می‌دهد.
    // اگر می‌خواهی فقط محتوای امنیتی را نشان دهی، بهتر است مستقیماً از Scaffold و OmniGlassPanel استفاده کنی.
    // اما برای رفع خطا طبق ساختار فعلی شما:
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // نمایش InsightPage به عنوان پس‌زمینه یا ساختار اصلی
          InsightPage(controller: _scrollController),

          // نمایش محتوای امنیتی روی صفحه به صورت Overlay یا جایگزین
          Center(
            child: Container(
              width: UIHelper.getAdaptiveWidth(context),
              padding: const EdgeInsets.all(16.0),
              child: OmniGlassPanel(
                title: 'امنیت داده‌ها (AES-256)',
                fullBorderRadius: true,
                showCloseButton: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.lock_person_rounded,
                        size: 64,
                        color: Colors.greenAccent,
                      ),
                      const SizedBox(height: 20),
                      const AdaptiveText(
                        'دیتابیس با استاندارد AES-256 رمزنگاری شد',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const Divider(height: 40, color: Colors.white24),
                      _buildSecurityFeature(
                        Icons.vpn_key_rounded,
                        'کلید سخت‌افزاری',
                        'ذخیره شده در Secure Storage سخت‌افزاری',
                      ),
                      _buildSecurityFeature(
                        Icons.verified_user_rounded,
                        'انطباق با PIPEDA',
                        'استاندارد حفاظت از حریم خصوصی کانادا',
                      ),
                      _buildSecurityFeature(
                        Icons.phonelink_lock_rounded, // اصلاح شده
                        'محافظت بیومتریک',
                        'دسترسی محدود به صاحب دستگاه',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFeature(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdaptiveText(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                AdaptiveText(subtitle,
                    style:
                        const TextStyle(fontSize: 11, color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
