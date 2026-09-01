import 'package:archive/archive.dart';

/// Bundles multiple named export files into one in-memory ZIP archive
/// (Issue #258's "export all project-related artifacts... in a single
/// ZIP file") — the local, in-process equivalent of the issue's
/// Node.js `archiver`/BullMQ pipeline (no backend exists in this
/// repo; see PR notes). [files] should already use the issue's own
/// numbered naming convention (e.g. "01_Traceability_Report.pdf").
class BuildBatchExportZipArchive {
  static List<int> call(List<({String filename, List<int> bytes})> files) {
    final archive = Archive();
    for (final file in files) {
      archive.addFile(ArchiveFile(file.filename, file.bytes.length, file.bytes));
    }
    return ZipEncoder().encode(archive) ?? const [];
  }
}
