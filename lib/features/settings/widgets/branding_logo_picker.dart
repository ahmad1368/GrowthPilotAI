import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Logo upload row for the branding settings screen (Issue #257) —
/// picks an image via the OS gallery and hands raw bytes back to the
/// caller; no `image_cropper` dependency added, just a fixed preview
/// box (see PR notes).
class BrandingLogoPicker extends StatelessWidget {
  final Uint8List? logoBytes;
  final ValueChanged<Uint8List?> onChanged;

  const BrandingLogoPicker({super.key, required this.logoBytes, required this.onChanged});

  Future<void> _pick() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 512);
    if (file == null) return;
    onChanged(await file.readAsBytes());
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Row(children: [
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(color: colors.muted, borderRadius: BorderRadius.circular(8)),
        child: logoBytes == null
            ? Icon(Icons.image_outlined, color: colors.mutedForeground)
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(logoBytes!, fit: BoxFit.cover),
              ),
      ),
      const SizedBox(width: 12),
      TextButton(onPressed: _pick, child: const Text('Upload logo')),
      if (logoBytes != null) TextButton(onPressed: () => onChanged(null), child: const Text('Remove')),
    ]);
  }
}
