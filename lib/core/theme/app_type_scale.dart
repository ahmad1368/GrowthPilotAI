import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/utils/ui_helper.dart';

/// Adaptive type scale (Issue #175 AC: "Headings must scale correctly
/// (e.g., 24px on Mobile, 32px on Web) while maintaining the same
/// weight and line-height ratio") — reuses this app's existing
/// [UIHelper.isWide] layout breakpoint instead of a separate
/// React/Tailwind build step (no React web app exists here).
class AppTypeScale {
  static TextStyle heading1(BuildContext context) =>
      _scaled(context, mobile: 24, wide: 32, weight: FontWeight.bold, height: 1.2);
  static TextStyle heading2(BuildContext context) =>
      _scaled(context, mobile: 20, wide: 26, weight: FontWeight.bold, height: 1.2);
  static TextStyle heading3(BuildContext context) =>
      _scaled(context, mobile: 16, wide: 20, weight: FontWeight.w600, height: 1.3);
  static TextStyle body(BuildContext context) =>
      _scaled(context, mobile: 14, wide: 15, weight: FontWeight.normal, height: 1.4);
  static TextStyle caption(BuildContext context) =>
      _scaled(context, mobile: 12, wide: 12, weight: FontWeight.w400, height: 1.3);

  static TextStyle _scaled(
    BuildContext context, {
    required double mobile,
    required double wide,
    required FontWeight weight,
    required double height,
  }) {
    final size = UIHelper.isWide(context) ? wide : mobile;
    return TextStyle(fontSize: size, fontWeight: weight, height: height);
  }
}
