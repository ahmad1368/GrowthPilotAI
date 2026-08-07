import '../../../../objectbox.g.dart';
import '../entities/micro_credit_loan_entity.dart';

/// Insert-or-update CRUD for micro-credit loans (Issue #419),
/// mirroring [PreOrderReservationRepository]'s upsert + lookup
/// pattern.
class MicroCreditLoanRepository {
  final Box<MicroCreditLoanEntity> _box;

  MicroCreditLoanRepository(this._box);

  int save(MicroCreditLoanEntity loan) => _box.put(loan);

  List<MicroCreditLoanEntity> getAll() => _box.getAll();

  List<MicroCreditLoanEntity> forAccount(int creditAccountId) =>
      getAll().where((l) => l.creditAccountId == creditAccountId).toList();
}
