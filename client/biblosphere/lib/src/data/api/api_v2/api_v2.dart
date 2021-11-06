import 'package:biblosphere/src/data/api/api_v2/requests/get_recommendations_by_books_request.dart';
import 'package:biblosphere/src/data/api/api_v2/requests/get_recomendations_by_books_request.dart';
import 'package:biblosphere/src/domain/entities/config.dart';
import 'package:biblosphere/src/data/api/base_api.dart';

class ApiV2 extends BaseApi with GetNewBooksRequest, GetRecommendationsRequest {
  const ApiV2({required ApiConfig config}) : super(config: config);
}
