import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

/// One file to include in a [ShareMultipleExportFiles] call.
typedef ExportFileParams = ({List<int> bytes, String mimeType, String filename});

/// "XFile Support: use Share.shareXFiles to handle multiple files at
/// once — allowing a BA to send a PDF report and an Excel matrix in a
/// single 'Share' action" (Issue #250) — also sets the "Subject Lines"
/// AC (email subject pre-populated with the export title + date).
class ShareMultipleExportFiles {
  static Future<void> call(List<ExportFileParams> files, {required String subject}) {
    return SharePlus.instance.share(ShareParams(
      subject: subject,
      files: [
        for (final file in files)
          XFile.fromData(Uint8List.fromList(file.bytes), mimeType: file.mimeType, name: file.filename),
      ],
    ));
  }
}
