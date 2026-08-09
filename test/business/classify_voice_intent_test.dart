import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_voice_intent.dart';
import 'package:growth_pilot_ai/core/enum/voice_intent.dart';

void main() {
  test('detects a create-asset command', () {
    expect(ClassifyVoiceIntent.call('post a new product for \$50'), VoiceIntent.createAsset);
  });

  test('detects a send-message command', () {
    expect(ClassifyVoiceIntent.call('send message tell them yes'), VoiceIntent.sendMessage);
  });

  test('detects a market-query command', () {
    expect(ClassifyVoiceIntent.call('check trends for lumber'), VoiceIntent.marketQuery);
  });

  test('falls back to the screen context when the transcript is ambiguous', () {
    expect(
        ClassifyVoiceIntent.call('yes do it', screenContext: 'product_form'),
        VoiceIntent.createAsset);
  });

  test('is unknown with no keyword match and no screen context', () {
    expect(ClassifyVoiceIntent.call('what is the weather today'), VoiceIntent.unknown);
  });
}
