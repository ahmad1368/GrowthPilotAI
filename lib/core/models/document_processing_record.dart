import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// The finished output of one local run of the document pipeline
/// (Issue #232) — cached by [contentHash] so a re-submitted document can
/// reuse it instead of re-running extraction (the AC's "saves
/// significant LLM costs").
@immutable
class DocumentProcessingRecord {
  final String contentHash;
  final String sanitizedText;
  final List<ExtractedRequirement> requirements;
  final DateTime processedAt;

  const DocumentProcessingRecord({
    required this.contentHash,
    required this.sanitizedText,
    required this.requirements,
    required this.processedAt,
  });
}
