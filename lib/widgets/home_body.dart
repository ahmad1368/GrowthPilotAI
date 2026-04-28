import 'package:flutter/material.dart';
import 'insight_card.dart';

class HomeBody extends StatelessWidget {
  final ScrollController controller;

  const HomeBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(20, kToolbarHeight + 40, 20, 100),
      itemCount: 15,
      itemBuilder: (context, index) => InsightCard(
        title: "Insight #$index",
        description: "AI optimized analysis.",
        efficiency: "${(index + 1) * 7}%",
      ),
    );
  }
}
