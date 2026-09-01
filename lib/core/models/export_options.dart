import 'package:flutter/foundation.dart';

/// Request for a data export: which [fields] (columns) to include and in what
/// order, plus any [anonymizeFields] whose values are masked (for sharing with
/// external consultants — PII protection).
@immutable
class ExportOptions {
  final List<String> fields;
  final Set<String> anonymizeFields;

  const ExportOptions({
    required this.fields,
    this.anonymizeFields = const {},
  });
}
