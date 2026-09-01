import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Postal-code entry + "Set Location" button (Issue #213) — the
/// manual-override UX the acceptance criteria call for, split out of
/// [GeoLocationView] to stay under the file line cap.
class GeoLocationSearchInput extends StatefulWidget {
  final void Function(String postalCode) onSetLocation;
  const GeoLocationSearchInput({super.key, required this.onSetLocation});

  @override
  State<GeoLocationSearchInput> createState() => _GeoLocationSearchInputState();
}

class _GeoLocationSearchInputState extends State<GeoLocationSearchInput> {
  final _postalCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: ShadInput(
            placeholder: const Text('Postal code (e.g. V3J)'), controller: _postalCode),
      ),
      const SizedBox(width: 4),
      ShadButton.ghost(
        onPressed: () => widget.onSetLocation(_postalCode.text),
        child: const Text('Set Location'),
      ),
    ]);
  }
}
