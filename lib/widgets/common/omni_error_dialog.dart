import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/widgets/adaptive_text.dart';
import 'package:growth_pilot_ai/widgets/omni_glass_panel.dart';

enum OmniMessageType { info, warning, error, schedule, success }

class OmniErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final OmniMessageType type;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? footerText;
  final double opacity;

  const OmniErrorDialog({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.actionLabel,
    this.onAction,
    this.footerText,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        constraints:
            const BoxConstraints(maxWidth: 550), // بهینه‌سازی برای نمایشگر عریض
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: OmniGlassPanel(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HeaderSection(type: type, title: title),
                const SizedBox(height: 20),
                _ScrollableContent(message: message, isDark: isDark),
                if (footerText != null) _FooterSection(text: footerText!),
                const SizedBox(height: 24),
                _ActionButtons(
                    actionLabel: actionLabel,
                    onAction: onAction,
                    isDark: isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- منطق تفکیک شده: بخش پیام با قابلیت اسکرول برای متون طولانی OCR ---
class _ScrollableContent extends StatelessWidget {
  final String message;
  final bool isDark;

  const _ScrollableContent({required this.message, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height *
            0.45, // تطبیق با مانیتور و موبایل
      ),
      child: Scrollbar(
        thumbVisibility: true,
        thickness: 3,
        radius: const Radius.circular(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: AdaptiveText(
              message,
              textAlign: TextAlign.left, // نمایش دقیق متون OCR (انگلیسی)
              style: TextStyle(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.8)
                    : Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- منطق تفکیک شده: سربرگ و آیکون ---
class _HeaderSection extends StatelessWidget {
  final OmniMessageType type;
  final String title;
  const _HeaderSection({required this.type, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final config = _getTypeConfig(type, isDark);

    return Column(
      children: [
        Icon(config.icon, size: 52, color: config.color),
        const SizedBox(height: 12),
        AdaptiveText(
          title,
          style: TextStyle(
              color: config.color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5),
        ),
      ],
    );
  }

  _TypeConfig _getTypeConfig(OmniMessageType type, bool isDark) {
    switch (type) {
      case OmniMessageType.error:
        return _TypeConfig(Icons.dangerous_outlined,
            isDark ? Colors.redAccent : Colors.red[700]!);
      case OmniMessageType.warning:
        return _TypeConfig(Icons.warning_amber_rounded,
            isDark ? Colors.orangeAccent : Colors.orange[800]!);
      case OmniMessageType.schedule:
        return _TypeConfig(Icons.history_toggle_off_rounded,
            isDark ? Colors.blueAccent : Colors.blue[700]!);
      case OmniMessageType.success:
        return _TypeConfig(Icons.task_alt_rounded,
            isDark ? Colors.greenAccent : Colors.green[700]!);
      default:
        return _TypeConfig(Icons.info_outline_rounded,
            isDark ? Colors.cyanAccent : Colors.cyan[800]!);
    }
  }
}

class _TypeConfig {
  final IconData icon;
  final Color color;
  _TypeConfig(this.icon, this.color);
}

// --- منطق تفکیک شده: فوتر ---
class _FooterSection extends StatelessWidget {
  final String text;
  const _FooterSection({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: AdaptiveText(
        text,
        style: TextStyle(
            fontSize: 11,
            color: Colors.grey.withValues(alpha: 0.6),
            fontStyle: FontStyle.italic),
      ),
    );
  }
}

// --- منطق تفکیک شده: دکمه‌های عملیاتی ---
class _ActionButtons extends StatelessWidget {
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool isDark;
  const _ActionButtons({this.actionLabel, this.onAction, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.end, // دکمه‌ها در سمت راست برای دسترسی بهتر
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: AdaptiveText("بستن",
              style:
                  TextStyle(color: isDark ? Colors.white38 : Colors.black45)),
        ),
        if (onAction != null) ...[
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent.withValues(alpha: 0.1),
              foregroundColor: Colors.cyanAccent,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Get.back();
              onAction!();
            },
            child: AdaptiveText(actionLabel ?? "تایید",
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ],
    );
  }
}
