import 'package:flutter/material.dart';
import '../adaptive_text.dart';

class SourceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SourceItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.cyanAccent, size: 24),
      title: AdaptiveText(label,
          style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
