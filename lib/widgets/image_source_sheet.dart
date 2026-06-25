import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/widgets/omni_step_progress.dart';
import 'package:image_picker/image_picker.dart';

// ایمپورت ویجت‌های اختصاصی پروژه شما
import 'omni_glass_panel.dart';
import 'adaptive_text.dart';
import '../core/constants/scan_pipelines.dart';

class ImageSourceSheet extends StatelessWidget {
  final Function(ImageSource) onSourceSelected;

  const ImageSourceSheet({super.key, required this.onSourceSelected});

  @override
  Widget build(BuildContext context) {
    final isDark = Get.isDarkMode;

    return Material(
      color: Colors.transparent,
      child: OmniGlassPanel(
        opacity: isDark ? 0.1 : 0.9,
        fullBorderRadius: false,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ۱. هندل بالای صفحه برای بستن (Handle)
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 25),

              // ۲. نوار پیشرفت استاندارد (نمایش مرحله اول: انتخاب منبع)
              OmniStepProgress(
                allSteps: ScanPipelines.docScanSteps,
                currentStepId: 'picking', // مرحله فعلی: انتخاب منبع
                subProgress: 0.5, // ۵۰ درصد این مرحله طی شده
              ),

              const SizedBox(height: 30),

              const AdaptiveText(
                "انتخاب منبع تصویر",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),

              // ۳. گزینه‌ها با قابلیت Hover و انیمیشن
              _InteractiveOption(
                icon: Icons.camera_alt_rounded,
                label: "دوربین",
                onTap: () => onSourceSelected(ImageSource.camera),
                isDark: isDark,
              ),

              const SizedBox(height: 12),

              _InteractiveOption(
                icon: Icons.photo_library_rounded,
                label: "گالری",
                onTap: () => onSourceSelected(ImageSource.gallery),
                isDark: isDark,
              ),

              const SizedBox(height: 40), // فضای خالی پایین برای زیبایی
            ],
          ),
        ),
      ),
    );
  }
}

/// ویجت داخلی برای مدیریت وضعیت Hover و انیمیشن‌های گزینه‌ها
class _InteractiveOption extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _InteractiveOption({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  State<_InteractiveOption> createState() => _InteractiveOptionState();
}

class _InteractiveOptionState extends State<_InteractiveOption> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          // افکت هایلایت حاشیه در حالت هاور
          border: Border.all(
            color: _isHovered
                ? Colors.cyanAccent.withValues(alpha: .5)
                : Colors.white.withValues(alpha: .05),
            width: 1.5,
          ),
          // تغییر رنگ پس‌زمینه بسیار ملایم
          color: _isHovered
              ? Colors.cyan.withValues(alpha: widget.isDark ? 0.1 : 0.05)
              : Colors.transparent,
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              // افکت هاله نوری پشت آیکون (Micro-interaction)
              if (_isHovered) const _ScanningPulseEffect(),

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: .15),
                  shape: BoxShape.circle,
                ),
                child: Icon(widget.icon, color: Colors.cyan),
              ),
            ],
          ),
          title: AdaptiveText(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
              color: _isHovered ? Colors.cyanAccent : null,
            ),
          ),
          trailing: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.only(right: _isHovered ? 5 : 0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: _isHovered
                  ? Colors.cyanAccent
                  : (widget.isDark ? Colors.white24 : Colors.black26),
              size: 16,
            ),
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}

/// افکت ضربان نوری (Pulse) که حس "آماده پردازش بودن" را القا می‌کند
class _ScanningPulseEffect extends StatefulWidget {
  const _ScanningPulseEffect();

  @override
  State<_ScanningPulseEffect> createState() => _ScanningPulseEffectState();
}

class _ScanningPulseEffectState extends State<_ScanningPulseEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.1, end: 0.6).animate(_controller),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withValues(alpha: .5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}
