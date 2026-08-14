import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/messaging/widgets/translation_chat_body.dart';

/// Registers the On-Device Local AI Cross-Language Messaging Bridge
/// (Issue #430) as a pluggable report widget under id
/// `ON_DEVICE_TRANSLATION_BRIDGE` (#111).
class TranslationChatReportWidget extends BaseReportWidget {
  const TranslationChatReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const TranslationChatBody();
  }
}
