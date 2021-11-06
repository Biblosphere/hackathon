import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/config.dart';

abstract class BaseApiV2 extends BaseApi {
  const BaseApiV2({required ApiConfig config}) : super(config: config);

  Future<Either<Iterable<Book>>> getNewBooks(String id);

  Future<Either<Iterable<Book>>> getRecomandations(Iterable<Book> likeBooks);
}
