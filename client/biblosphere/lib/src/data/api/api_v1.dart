import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/data/api/requests/search_top_books_request.dart';
import 'package:biblosphere/src/domain/entities/config.dart';

class ApiV1Impl extends BaseApiV1 with SearchTopBooksRequest {
  const ApiV1Impl({required ApiConfig config}) : super(config: config);
}
