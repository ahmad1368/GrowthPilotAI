import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [Issue #810] Live numeric "forecast window" input — replaces the old
/// fixed Next-3/Next-7-days chips. Every keystroke that parses to a
/// valid day count (clamped to [minDays]-[maxDays]) immediately notifies
/// [onChanged]; invalid/empty input is ignored rather than crashing or
/// clearing the last valid value.
class ForecastDaysInput extends StatefulWidget {
  static const minDays = 1;
  static const maxDays = 90;

  final int days;
  final ValueChanged<int> onChanged;

  const ForecastDaysInput({super.key, required this.days, required this.onChanged});

  @override
  State<ForecastDaysInput> createState() => _ForecastDaysInputState();
}

class _ForecastDaysInputState extends State<ForecastDaysInput> {
  late final _controller = TextEditingController(text: '${widget.days}');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String text) {
    final parsed = int.tryParse(text);
    if (parsed == null) return;
    final clamped = parsed.clamp(ForecastDaysInput.minDays, ForecastDaysInput.maxDays);
    widget.onChanged(clamped);
    // Snap the field itself to the clamped value too — otherwise it kept
    // showing e.g. "999" while every computed value used 90.
    if (clamped != parsed) {
      _controller.value = TextEditingValue(
        text: '$clamped',
        selection: TextSelection.collapsed(offset: '$clamped'.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: _handleChanged,
        decoration: const InputDecoration(
          labelText: 'Days',
          isDense: true,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
