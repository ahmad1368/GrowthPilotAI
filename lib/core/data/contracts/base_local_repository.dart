import 'package:growth_pilot_ai/core/models/omni_response.dart';

abstract class BaseLocalRepository<T> {
  // عملیات غیرهمزمان (Async)
  Future<OmniResponse<int>> insertAsync(T entity);
  Future<OmniResponse<List<T>>> getAllAsync();
  Future<OmniResponse<bool>> deleteAsync(int id);

  // عملیات همزمان (Sync)
  OmniResponse<int> insertSync(T entity);
  OmniResponse<List<T>> getAllSync();
  OmniResponse<bool> deleteSync(int id);
}
