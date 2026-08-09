import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_voice_confirmation_summary.dart';
import 'package:growth_pilot_ai/core/enum/voice_intent.dart';

void main() {
  test('summarizes a create-asset command with its title and price', () {
    final summary = BuildVoiceConfirmationSummary.call((
      intent: VoiceIntent.createAsset,
      transcript: 'post forklift for \$500',
      title: 'forklift',
      price: 500.0,
      messageBody: null,
    ));
    expect(summary, 'Post "forklift" at \$500.0?');
  });

  test('summarizes a send-message command', () {
    final summary = BuildVoiceConfirmationSummary.call((
      intent: VoiceIntent.sendMessage,
      transcript: 'send message ok',
      title: null,
      price: null,
      messageBody: 'ok',
    ));
    expect(summary, 'Send message: "ok"?');
  });

  test('summarizes a market-query command', () {
    final summary = BuildVoiceConfirmationSummary.call((
      intent: VoiceIntent.marketQuery,
      transcript: 'check trends',
      title: null,
      price: null,
      messageBody: null,
    ));
    expect(summary, 'Show market trends?');
  });

  test('explains an unrecognized command instead of a blank summary', () {
    final summary = BuildVoiceConfirmationSummary.call((
      intent: VoiceIntent.unknown,
      transcript: 'what time is it',
      title: null,
      price: null,
      messageBody: null,
    ));
    expect(summary, contains("didn't understand"));
  });
}
