import 'package:growth_pilot_ai/core/enum/metadata_tag_category.dart';

/// One extracted "Smart Chip" annotation (Issue #128) — functional only,
/// never PII, per the "Privacy Integrity" AC.
typedef MessageTag = ({MetadataTagCategory category, String label, double confidence});

/// Renders a [MessageTag] as its display/persistence label, e.g. "#PriceNegotiation".
String messageTagDisplayLabel(MessageTag tag) => '#${tag.label.replaceAll(' ', '')}';
