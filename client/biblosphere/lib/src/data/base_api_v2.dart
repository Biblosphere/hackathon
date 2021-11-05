import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api.dart';
import 'package:biblosphere/src/domain/entities/new_book.dart';

abstract class BaseApiV2 extends BaseApi {
  const BaseApiV2({
    required String baseUrl,
    required Map<String, String> defaultHeaders,
  }) : super(baseUrl: baseUrl, defaultHeaders: defaultHeaders);

  Future<Either<NewBooks>> getNewBooks(String id);
}
