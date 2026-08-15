import 'package:flutter/material.dart';

/// One page of the first-launch feature tour (Issue #162).
@immutable
class OnboardingStep {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingStep({required this.icon, required this.title, required this.description});
}
