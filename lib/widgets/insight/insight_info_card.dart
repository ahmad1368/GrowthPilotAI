import 'package:flutter/material.dart';

/// Flat info card — replaces the former AdaptiveText usage with plain
/// Text and fixes hardcoded white colors that only looked correct in dark
/// mode; now derived from [Theme.of(context)].
class InsightInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const InsightInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: onSurface.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 0.15),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          _buildTextContent(context, onSurface),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, Color onSurface) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(color: onSurface.withValues(alpha: 0.5), fontSize: 11)),
        Text(value,
            style: TextStyle(
                color: onSurface, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
