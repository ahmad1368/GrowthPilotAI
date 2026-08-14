import '../../../../objectbox.g.dart';
import '../entities/banking_gateway_transaction_entity.dart';

/// Insert-or-update CRUD for banking-gateway transactions (Issue
/// #421), mirroring [EscrowAccountRepository]'s upsert pattern.
class BankingGatewayTransactionRepository {
  final Box<BankingGatewayTransactionEntity> _box;

  BankingGatewayTransactionRepository(this._box);

  int save(BankingGatewayTransactionEntity transaction) => _box.put(transaction);

  List<BankingGatewayTransactionEntity> getAll() => _box.getAll();
}
