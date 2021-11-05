import 'package:biblosphere/src/data/api/requests/get_new_books_request.dart';
import 'package:biblosphere/src/data/base_api_v2.dart';

class ApiV2Impl extends BaseApiV2 with GetNewBooksRequest {
  const ApiV2Impl({
    required String baseUrl,
    required Map<String, String> defaultHeaders,
  }) : super(
          baseUrl: baseUrl,
          defaultHeaders: defaultHeaders,
        );
}
