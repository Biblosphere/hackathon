import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/config.dart';

abstract class BaseApiV1 extends BaseApi {
  const BaseApiV1({required ApiConfig config}) : super(config: config);

  Future<Either<Iterable<Book>>> searchTopBooks(String source, int count);
}
