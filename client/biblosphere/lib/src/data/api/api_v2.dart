import 'package:biblosphere/src/data/api/requests/get_new_books_request.dart';
import 'package:biblosphere/src/data/api/requests/get_recomandations_request.dart';
import 'package:biblosphere/src/data/base_api_v2.dart';
import 'package:biblosphere/src/domain/entities/config.dart';

class ApiV2Impl extends BaseApiV2
    with GetNewBooksRequest, GetRecommendationsRequest {
  const ApiV2Impl({required ApiConfig config}) : super(config: config);
}
