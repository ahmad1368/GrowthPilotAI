import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Simulates a service invocation's GPS parameters and shows whether
/// access would be allowed (Issue #346, acceptance criteria 2-3) — this
/// app has no live GPS feed, so the tester enters lat/lng manually.
class GeofenceValidationField extends StatefulWidget {
  final String? Function(String featureName, double lat, double lng) onCheck;

  const GeofenceValidationField({super.key, required this.onCheck});

  @override
  State<GeofenceValidationField> createState() => _GeofenceValidationFieldState();
}

class _GeofenceValidationFieldState extends State<GeofenceValidationField> {
  final _featureNameController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  String? _result;

  void _check() {
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);
    if (_featureNameController.text.trim().isEmpty || lat == null || lng == null) return;
    setState(() => _result = widget.onCheck(_featureNameController.text.trim(), lat, lng));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Feature to test'), controller: _featureNameController),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
              child: ShadInput(
                  placeholder: const Text('Latitude'),
                  controller: _latController,
                  keyboardType: TextInputType.number)),
          const SizedBox(width: 8),
          Expanded(
              child: ShadInput(
                  placeholder: const Text('Longitude'),
                  controller: _lngController,
                  keyboardType: TextInputType.number)),
          const SizedBox(width: 8),
          ShadButton.outline(onPressed: _check, child: const Text('Check Access')),
        ]),
        if (_result != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_result!, style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary)),
          ),
      ],
    );
  }
}
