import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/disconnect_integration_executor.dart';
import 'package:growth_pilot_ai/business/disconnect_integration_usecase.dart';
import 'package:growth_pilot_ai/business/seed_integration_connections.dart';
import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/integration_connection_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/mapping_rule_repository.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_auth_service.dart';
import 'package:growth_pilot_ai/core/interfaces/bank_link_service.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import 'package:growth_pilot_ai/core/utils/oauth_state.dart';

const _providerOrder = ['plaid', 'quickbooks', 'xero'];

/// Drives the Integrations Dashboard (Issue #61): loads each provider's
/// connection status and runs the existing mock Connect/Refresh/Disconnect
/// flows against it.
class AccountingIntegrationsController extends GetxController {
  var connections = <IntegrationConnectionEntity>[].obs;
  var busyProviderId = RxnString();

  late IntegrationConnectionRepository _connectionRepo;
  late MappingRuleRepository _ruleRepo;

  @override
  void onInit() {
    super.onInit();
    final store = Get.find<ObjectBox>().store;
    _connectionRepo = IntegrationConnectionRepository(store.box());
    _ruleRepo = MappingRuleRepository(store.box());
    for (final seed
        in SeedIntegrationConnections.call(_connectionRepo.getAll())) {
      _connectionRepo.upsert(seed);
    }
    _reload();
  }

  void _reload() {
    final all = _connectionRepo.getAll();
    all.sort((a, b) => _providerOrder
        .indexOf(a.providerId)
        .compareTo(_providerOrder.indexOf(b.providerId)));
    connections.assignAll(all);
  }

  Future<void> connect(String providerId) async {
    busyProviderId.value = providerId;
    try {
      final entity = providerId == 'plaid'
          ? await _connectPlaid()
          : await _connectAccounting(providerId);
      _connectionRepo.upsert(entity);
      OmniLogger.info('Integrations Dashboard: $providerId -> '
          '${DashboardConnectionStatus.values[entity.dbStatus].name}.');
    } finally {
      busyProviderId.value = null;
      _reload();
    }
  }

  Future<IntegrationConnectionEntity> _connectPlaid() async {
    final bank = DependencyInjection.get<BankLinkService>();
    final tokenRes = await bank.createLinkToken();
    final publicTokenRes = tokenRes.success
        ? await bank.openLink(tokenRes.data!)
        : null;
    final accountRes = publicTokenRes?.success == true
        ? await bank.exchangePublicToken(publicTokenRes!.data!)
        : null;
    if (accountRes?.success != true) {
      return IntegrationConnectionEntity(
        providerId: 'plaid',
        providerLabel: 'Plaid',
        dbStatus: DashboardConnectionStatus.expired.index,
      );
    }
    return IntegrationConnectionEntity(
      providerId: 'plaid',
      providerLabel: 'Plaid',
      dbStatus: DashboardConnectionStatus.connected.index,
      accountLabel: accountRes!.data!.institutionName,
      lastSyncedAt: DateTime.now(),
    );
  }

  Future<IntegrationConnectionEntity> _connectAccounting(
      String providerId) async {
    final provider = providerId == 'quickbooks'
        ? AccountingProvider.quickbooks
        : AccountingProvider.xero;
    final auth = DependencyInjection.get<AccountingAuthService>();
    final request = auth.startAuthorization(provider);
    final result = await auth.handleCallback(
      provider: provider,
      code: OAuthState.generate(),
      returnedState: request.state,
      expectedState: request.state,
    );
    if (!result.success) {
      return IntegrationConnectionEntity(
        providerId: providerId,
        providerLabel: provider.label,
        dbStatus: DashboardConnectionStatus.expired.index,
      );
    }
    return IntegrationConnectionEntity(
      providerId: providerId,
      providerLabel: provider.label,
      dbStatus: DashboardConnectionStatus.connected.index,
      accountLabel: result.data!.realmId ?? provider.label,
      lastSyncedAt: DateTime.now(),
    );
  }

  void disconnect(String providerId) {
    final entity =
        connections.firstWhereOrNull((c) => c.providerId == providerId);
    if (entity == null) return;
    final plan = DisconnectIntegrationUseCase.call(entity);
    DisconnectIntegrationExecutor(_connectionRepo, _ruleRepo).execute(plan);
    OmniLogger.info('Integrations Dashboard: $providerId disconnected '
        '(User: Ahmad_Salem_Pour).');
    _reload();
  }
}
