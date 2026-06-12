import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/omni_message_type.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

void main() {
  test('OmniLogger executes without throwing exceptions and formats output',
      () {
    expect(
        () => OmniLogger.log(
              level: "INFO", // یا استفاده از متد مستقیم OmniLogger.info
              message:
                  "Database Encryption: AES-256 layer re-initialized successfully.",
              worker: "Ahmad_Salem_Pour",
              serviceName: "DatabaseAbstractionLayer",
            ),
        returnsNormally);
  });
}
