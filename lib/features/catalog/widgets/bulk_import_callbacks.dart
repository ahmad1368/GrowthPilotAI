import 'package:flutter/material.dart';

/// Bundles [BulkImportView]'s event callbacks (Issue #213) so the
/// widget's constructor doesn't need a handful of individual
/// parameters.
typedef BulkImportCallbacks = ({
  VoidCallback onCopyTemplate,
  VoidCallback onPreview,
  VoidCallback onImport,
  VoidCallback onCopyErrorLog,
  void Function(String field, int? index) onMapChanged,
});
