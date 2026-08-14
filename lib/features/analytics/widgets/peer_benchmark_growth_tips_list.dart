import 'package:flutter/material.dart';

/// Bulleted growth tips for the axes where the merchant trails peers
/// (Issue #363).
class PeerBenchmarkGrowthTipsList extends StatelessWidget {
  final List<String> tips;

  const PeerBenchmarkGrowthTipsList({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    if (tips.isEmpty) {
      return const Text("You're at or above the peer average on every axis.");
    }
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final tip in tips)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(color: scheme.primary)),
                Expanded(child: Text(tip, style: const TextStyle(fontSize: 12))),
              ],
            ),
          ),
      ],
    );
  }
}
