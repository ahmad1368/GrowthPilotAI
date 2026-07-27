import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/export_inventory_valuation_csv.dart';
import 'package:growth_pilot_ai/business/export_inventory_valuation_pdf.dart';
import 'package:growth_pilot_ai/core/models/item_valuation.dart';

/// "Export" popup for the valuation summary (Issue #446): CSV or PDF.
class InventoryValuationExportButton extends StatefulWidget {
  final GlobalKey boundaryKey;
  final List<ItemValuation> valuations;
  final String title;

  const InventoryValuationExportButton(
      {super.key, required this.boundaryKey, required this.valuations, required this.title});

  @override
  State<InventoryValuationExportButton> createState() => _InventoryValuationExportButtonState();
}

class _InventoryValuationExportButtonState extends State<InventoryValuationExportButton> {
  bool _isExporting = false;

  Future<void> _csv() => ExportInventoryValuationCsv.call(widget.valuations, widget.title);
  Future<void> _pdf() => ExportInventoryValuationPdf.call(widget.boundaryKey, widget.title);
  Future<void> _run(Future<void> Function() action) async {
    setState(() => _isExporting = true);
    try {
      await action();
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isExporting) {
      return const Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
            width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)));
    }
    return PopupMenuButton<void>(
      tooltip: 'Export valuation',
      icon: const Icon(Icons.ios_share, size: 18),
      itemBuilder: (context) => [
        PopupMenuItem(onTap: () => _run(_csv), child: const Text('Export as CSV')),
        PopupMenuItem(onTap: () => _run(_pdf), child: const Text('Export as PDF')),
      ],
    );
  }
}
