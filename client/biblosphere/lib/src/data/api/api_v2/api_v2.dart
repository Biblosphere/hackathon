import 'package:biblosphere/src/data/api/api_v2/requests/get_recommendations_by_id_request.dart';
import 'package:biblosphere/src/data/api/api_v2/requests/get_recommendations_by_books_request.dart';
import 'package:biblosphere/src/domain/entities/config.dart';
import 'package:biblosphere/src/data/api/base_api.dart';

class ApiV2 extends BaseApi
    with GetRecommendationsByIdRequest, GetRecommendationsByBooksRequest {
  const ApiV2({required ApiConfig config}) : super(config: config);
}
