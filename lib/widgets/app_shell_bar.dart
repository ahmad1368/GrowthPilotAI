import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/widgets/app_shell_title_icon.dart';

/// Scroll-adaptive app bar (Issue #6): fades from transparent to the flat
/// theme surface color as [opacity] rises with scroll offset (see
/// [HomeLogic.appBarOpacity]). Flat, no BackdropFilter/blur.
class AppShellBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final IconData? titleIcon;
  final VoidCallback? onTitleIconTap;
  final double opacity;
  final List<Widget>? actions;

  const AppShellBar({
    super.key,
    this.title,
    this.titleIcon,
    this.onTitleIconTap,
    required this.opacity,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final surface = AppDesignTokens.background(brightness);
    final foreground = isDark ? Colors.white : Colors.black;

    return AppBar(
      elevation: 0,
      backgroundColor: Color.lerp(surface.withValues(alpha: 0), surface, opacity),
      iconTheme: IconThemeData(color: foreground),
      // Issue #6 AC: status bar icons stay legible across the fade.
      systemOverlayStyle:
          isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      // #825: text title replaced with an (optionally tappable, #835) icon.
      title: title != null
          ? Text(title!, style: TextStyle(fontWeight: FontWeight.bold, color: foreground))
          : (titleIcon != null
              ? AppShellTitleIcon(
                  icon: titleIcon!, foreground: foreground, onTap: onTitleIconTap)
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
