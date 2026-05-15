import '../models/omni_response.dart';

abstract class BaseFinancialParser<T, R> {
  Future<OmniResponse<T>> parse(R rawData);
  bool validate(T model);
}
