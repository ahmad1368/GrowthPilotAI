import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/xero_tenant_selector.dart';
import 'package:growth_pilot_ai/core/models/xero_tenant.dart';
import 'package:growth_pilot_ai/core/utils/pkce.dart';

void main() {
  group('Pkce.generateVerifier', () {
    test('is URL-safe and unique per call', () {
      final verifier = Pkce.generateVerifier();
      expect(verifier, matches(RegExp(r'^[A-Za-z0-9_-]+$')));
      expect(verifier.length, greaterThanOrEqualTo(43));
      expect(verifier, isNot(Pkce.generateVerifier()));
    });
  });

  group('Pkce.challengeFor', () {
    test('matches the RFC 7636 S256 test vector', () {
      // Appendix B of RFC 7636.
      expect(
        Pkce.challengeFor('dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk'),
        'E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM',
      );
    });

    test('is deterministic and padding-free', () {
      final c = Pkce.challengeFor('abc');
      expect(c, Pkce.challengeFor('abc'));
      expect(c, isNot(contains('=')));
    });
  });

  group('XeroTenantSelector', () {
    const a = XeroTenant(tenantId: 't1', tenantName: 'Acme');
    const b = XeroTenant(tenantId: 't2', tenantName: 'Beta');

    test('auto-selects when exactly one tenant is authorized', () {
      expect(XeroTenantSelector.autoOrNull([a])?.tenantId, 't1');
      expect(XeroTenantSelector.autoOrNull([a, b]), isNull);
      expect(XeroTenantSelector.autoOrNull([]), isNull);
    });

    test('byId returns the chosen tenant or null', () {
      expect(XeroTenantSelector.byId([a, b], 't2')?.tenantName, 'Beta');
      expect(XeroTenantSelector.byId([a, b], 'nope'), isNull);
    });
  });
}
