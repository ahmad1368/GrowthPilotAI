import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_voice_command_executable.dart';
import 'package:growth_pilot_ai/core/enum/voice_intent.dart';

void main() {
  test('a recognized intent is executable', () {
    expect(
        IsVoiceCommandExecutable.call((
          intent: VoiceIntent.marketQuery,
          transcript: 'check trends',
          title: null,
          price: null,
          messageBody: null,
        )),
        isTrue);
  });

  test('an unrecognized command is not executable', () {
    expect(
        IsVoiceCommandExecutable.call((
          intent: VoiceIntent.unknown,
          transcript: 'gibberish',
          title: null,
          price: null,
          messageBody: null,
        )),
        isFalse);
  });
}
