import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_export_file_name.dart';
import 'package:growth_pilot_ai/business/decode_export_data.dart';
import 'package:growth_pilot_ai/business/save_export_file.dart';
import 'package:growth_pilot_ai/business/share_export_file.dart';
import 'package:growth_pilot_ai/core/models/export_payload.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Print Preview" screen before final export (Issue #222, AC: "choose
/// the format and quality") — Save writes locally (Mobile only), Share
/// opens the OS share sheet on every platform.
class ExportPreviewBottomSheet extends StatelessWidget {
  final ExportPayload payload;

  const ExportPreviewBottomSheet({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final bytes = DecodeExportData.call(payload.base64Data);
    final fileName = BuildExportFileName.call(payload.format, DateTime.now());

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Export as ${payload.format.name.toUpperCase()}',
              style: TextStyle(color: colors.foreground, fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            children: [
              ShadButton(
                onPressed: () => SaveExportFile.call(bytes, fileName),
                child: const Text('Save'),
              ),
              const SizedBox(width: 8),
              ShadButton.outline(
                onPressed: () => ShareExportFile.call(bytes, payload.format, fileName),
                child: const Text('Share'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
