import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/decode_export_data.dart';

void main() {
  group('DecodeExportData', () {
    test('decodes base64 back to the original bytes', () {
      final original = [1, 2, 3, 255, 0];
      final encoded = base64Encode(original);

      expect(DecodeExportData.call(encoded), original);
    });
  });
}
