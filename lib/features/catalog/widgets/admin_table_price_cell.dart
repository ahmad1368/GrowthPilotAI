import 'package:flutter/material.dart';

/// A single click-to-edit price cell (Issue #143, "Inline Editing").
class AdminTablePriceCell extends StatefulWidget {
  final double price;
  final void Function(double) onChanged;
  const AdminTablePriceCell({super.key, required this.price, required this.onChanged});

  @override
  State<AdminTablePriceCell> createState() => _AdminTablePriceCellState();
}

class _AdminTablePriceCellState extends State<AdminTablePriceCell> {
  late final _controller = TextEditingController(text: widget.price.toStringAsFixed(2));

  void _submit(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null) widget.onChanged(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 12),
        onSubmitted: _submit,
      ),
    );
  }
}
