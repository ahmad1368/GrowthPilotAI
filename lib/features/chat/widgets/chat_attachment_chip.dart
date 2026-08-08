import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Media Tray"/"Document Chip" (Issue #133 AC) — renders the compressed
/// bytes directly with [Image.memory] for images (no signed URL/CDN
/// fetch exists locally); other MIME types fall back to a name/size
/// chip since there's no document viewer wired up yet.
class ChatAttachmentChip extends StatelessWidget {
  final Uint8List bytes;
  final String fileName;
  final int fileSize;
  final String mimeType;

  const ChatAttachmentChip({
    super.key,
    required this.bytes,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
  });

  @override
  Widget build(BuildContext context) {
    if (mimeType.startsWith('image/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(bytes, height: 140, fit: BoxFit.cover),
      );
    }
    final colors = ShadTheme.of(context).colorScheme;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.description_outlined, size: 16, color: colors.mutedForeground),
      const SizedBox(width: 6),
      Flexible(child: Text(fileName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12))),
      const SizedBox(width: 6),
      Text('${(fileSize / 1024).toStringAsFixed(1)} KB',
          style: TextStyle(fontSize: 10, color: colors.mutedForeground)),
    ]);
  }
}
