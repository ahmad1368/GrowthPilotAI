/// "Subject Lines: pre-populate the 'Subject' field for emails using
/// the project name and current date" (Issue #250) — this app has no
/// project-name concept, so "GrowthPilotAI" itself stands in (see PR
/// notes).
class BuildExportSubject {
  static String call(String title, {DateTime? timestamp}) {
    final now = timestamp ?? DateTime.now();
    final date = '${now.year}-${_pad(now.month)}-${_pad(now.day)}';
    return 'GrowthPilotAI $title — $date';
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');
}
