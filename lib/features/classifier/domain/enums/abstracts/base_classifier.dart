import 'package:growth_pilot_ai/core/models/omni_response.dart';
import '../models/classifier_request.dart';
import '../models/classifier_response_model.dart';

abstract class BaseClassifier {
  Future<void> loadModel();
  Future<OmniResponse<ClassifierResponseModel>> classify(
      ClassifierRequest request);
  void dispose();
}
