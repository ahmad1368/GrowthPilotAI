import 'package:growth_pilot_ai/business/slugify_title.dart';

/// "Auto-Labeling: automatically append the Project Name and Version
/// Number to the filename (e.g., GrowthPilotAI_Flow_v1.2.svg)" (Issue
/// #249) — this app has no project-name/version-number concept, so a
/// `YYYYMMDD-HHmm` timestamp stands in for "version" (see PR notes).
class BuildVersionedExportFilename {
  static String call(String baseName, String extension, {DateTime? timestamp}) {
    final now = timestamp ?? DateTime.now();
    final stamp =
        '${now.year}${_pad(now.month)}${_pad(now.day)}-${_pad(now.hour)}${_pad(now.minute)}';
    return 'GrowthPilotAI_${SlugifyTitle.call(baseName)}_$stamp.$extension';
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');
}
