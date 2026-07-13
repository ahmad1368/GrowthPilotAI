import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_bank_link_service.dart';

void main() {
  late MockBankLinkService service;

  setUp(() => service = MockBankLinkService());

  test('createLinkToken returns a link token', () async {
    final response = await service.createLinkToken();
    expect(response.success, isTrue);
    expect(response.data, isNotEmpty);
  });

  group('openLink', () {
    test('returns a public token for a valid link token', () async {
      final response = await service.openLink('link-sandbox-ca');
      expect(response.success, isTrue);
      expect(response.data, isNotEmpty);
    });

    test('rejects an empty link token', () async {
      final response = await service.openLink('');
      expect(response.success, isFalse);
      expect(response.statusCode, 400);
    });
  });

  group('exchangePublicToken', () {
    test('returns a connected Canadian bank account', () async {
      final response =
          await service.exchangePublicToken('public-sandbox-token');
      expect(response.success, isTrue);
      expect(response.data?.institutionName, 'RBC Royal Bank');
      expect(response.data?.maskedLabel, contains('••'));
    });

    test('rejects an empty public token', () async {
      final response = await service.exchangePublicToken('');
      expect(response.success, isFalse);
      expect(response.statusCode, 400);
    });
  });

  test('full link flow yields a connected account', () async {
    final linkToken = (await service.createLinkToken()).data!;
    final publicToken = (await service.openLink(linkToken)).data!;
    final account = (await service.exchangePublicToken(publicToken)).data!;
    expect(account.institutionName, isNotEmpty);
    expect(account.mask, isNotEmpty);
  });
}
