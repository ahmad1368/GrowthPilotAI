import 'package:flutter/material.dart';
import '../models/process_step.dart';

class StepIndicatorPoint extends StatelessWidget {
  final ProcessStep step;
  final bool isCompleted;
  final bool isCurrent;

  const StepIndicatorPoint({
    super.key,
    required this.step,
    required this.isCompleted,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if ((isCompleted || isCurrent) && step.navigateTo != null) {
          Navigator.push(context, MaterialPageRoute(builder: step.navigateTo!));
        }
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: isCurrent ? 14 : 10,
            height: isCurrent ? 14 : 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrent
                  ? Colors.cyanAccent
                  : (isCompleted ? Colors.greenAccent : Colors.white24),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                          color: Colors.cyanAccent.withValues(alpha: 0.6),
                          blurRadius: 10)
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            step.order.toString(),
            style: TextStyle(
              color: isCurrent ? Colors.white : Colors.white24,
              fontSize: 9,
            ),
          )
        ],
      ),
    );
  }
}
