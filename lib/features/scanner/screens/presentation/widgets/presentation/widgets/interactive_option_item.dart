import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InteractiveOptionItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const InteractiveOptionItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  State<InteractiveOptionItem> createState() => _InteractiveOptionItemState();
}

class _InteractiveOptionItemState extends State<InteractiveOptionItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xff2563eb);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                _isHovered ? primaryColor : Colors.white.withValues(alpha: .05),
            width: 1.5,
          ),
          color: _isHovered
              ? primaryColor.withValues(alpha: isDark ? 0.1 : 0.05)
              : Colors.transparent,
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: .15),
                shape: BoxShape.circle),
            child: Icon(widget.icon, color: primaryColor),
          ),
          title: Text(
            widget.label,
            style: ShadTheme.of(context).textTheme.p.copyWith(
                  fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
                  color: _isHovered
                      ? primaryColor
                      : (isDark ? Colors.white : Colors.black),
                ),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: isDark ? Colors.white24 : Colors.black26, size: 16),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
