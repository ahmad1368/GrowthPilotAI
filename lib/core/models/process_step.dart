import 'package:flutter/material.dart';

class ProcessStep {
  final String id;
  final String title;
  final int order;
  final double weight;
  final Widget Function(BuildContext)? navigateTo;

  ProcessStep({
    required this.id,
    required this.title,
    required this.order,
    this.weight = 1.0,
    this.navigateTo,
  });
}


