import 'package:flutter/material.dart';

/// The "Column Mapper" — lets the vendor match their own CSV headers
/// to our system fields (Issue #213, "Mapping Wizard").
class BulkImportColumnMapper extends StatelessWidget {
  final List<String> header;
  final Map<String, int?> columnMap;
  final void Function(String field, int? index) onChanged;

  const BulkImportColumnMapper({
    super.key,
    required this.header,
    required this.columnMap,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (header.isEmpty) return const SizedBox.shrink();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Map your columns:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      for (final field in columnMap.keys)
        Row(children: [
          SizedBox(width: 70, child: Text(field, style: const TextStyle(fontSize: 12))),
          DropdownButton<int?>(
            value: columnMap[field],
            hint: const Text('—', style: TextStyle(fontSize: 12)),
            items: [
              for (var i = 0; i < header.length; i++)
                DropdownMenuItem(value: i, child: Text(header[i], style: const TextStyle(fontSize: 12))),
            ],
            onChanged: (index) => onChanged(field, index),
          ),
        ]),
    ]);
  }
}
