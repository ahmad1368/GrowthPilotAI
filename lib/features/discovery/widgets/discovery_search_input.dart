import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Search-as-you-type text field (Issue #121, "Search Suggestion
/// API" — this app has no separate suggestion endpoint, so every
/// keystroke re-runs the local search directly).
class DiscoverySearchInput extends StatelessWidget {
  final void Function(String term) onChanged;
  const DiscoverySearchInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ShadInput(placeholder: const Text('Search businesses...'), onChanged: onChanged);
  }
}
