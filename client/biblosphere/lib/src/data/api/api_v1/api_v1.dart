import 'package:biblosphere/src/data/api/base_api.dart';
import 'package:biblosphere/src/data/api/api_v1/requests/search_books_request.dart';
import 'package:biblosphere/src/domain/entities/config.dart';

class ApiV1 extends BaseApi with SearchBooksRequest {
  const ApiV1({required ApiConfig config}) : super(config: config);
}
