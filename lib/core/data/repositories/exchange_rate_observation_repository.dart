import '../../../../objectbox.g.dart';
import '../entities/exchange_rate_observation_entity.dart';

/// Basic CRUD for logged FX rate observations (Issue #371), mirroring
/// [CompetitorPriceObservationRepository]'s insert/getAll pattern.
class ExchangeRateObservationRepository {
  final Box<ExchangeRateObservationEntity> _box;

  ExchangeRateObservationRepository(this._box);

  int insert(ExchangeRateObservationEntity observation) =>
      _box.put(observation);

  List<ExchangeRateObservationEntity> getAll() => _box.getAll();
}
