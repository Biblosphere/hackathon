import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/data/api/requests/get_recomandations_request.dart';
import 'package:biblosphere/src/data/api/requests/recognize_photo_request.dart';
import 'package:biblosphere/src/data/api/requests/search_top_books_request.dart';

class ApiV1Impl extends BaseApiV1
    with
        GetRecomandationsRequest,
        RecognizePhotoRequest,
        SearchTopBooksRequest {
  const ApiV1Impl({
    required String baseUrl,
    required Map<String, String> defaultHeaders,
  }) : super(
          baseUrl: baseUrl,
          defaultHeaders: defaultHeaders,
        );
}
