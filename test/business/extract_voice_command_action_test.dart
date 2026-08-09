import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_voice_command_action.dart';
import 'package:growth_pilot_ai/core/enum/voice_intent.dart';

void main() {
  test('extracts a title and price for a create-asset command', () {
    final action = ExtractVoiceCommandAction.call('post used forklift for \$500');

    expect(action.intent, VoiceIntent.createAsset);
    expect(action.title, 'used forklift for \$500');
    expect(action.price, 500.0);
  });

  test('extracts a message body for a send-message command', () {
    final action = ExtractVoiceCommandAction.call('send message the price works for me');

    expect(action.intent, VoiceIntent.sendMessage);
    expect(action.messageBody, 'the price works for me');
  });

  test('a market-query command has no title, price, or message body', () {
    final action = ExtractVoiceCommandAction.call('check trends for lumber');

    expect(action.intent, VoiceIntent.marketQuery);
    expect(action.title, isNull);
    expect(action.price, isNull);
    expect(action.messageBody, isNull);
  });

  test('an unrecognized command stays unknown', () {
    final action = ExtractVoiceCommandAction.call('what time is it');
    expect(action.intent, VoiceIntent.unknown);
  });
}
