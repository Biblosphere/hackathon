import 'package:biblosphere/src/core/either.dart';
import 'package:biblosphere/src/data/base_api_v1.dart';
import 'package:biblosphere/src/data/base_api_v2.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/repo/book_repo.dart';

class BookRepoImpl implements BookRepo {
  const BookRepoImpl(this._apiV1, this._apiV2);

  final BaseApiV1 _apiV1;
  final BaseApiV2 _apiV2;

  @override
  Future<Either<Iterable<Book>>> getNewBooks(String id) {
    return _apiV2.getNewBooks(id);
  }

  @override
  Future<Either<Iterable<Book>>> getRecomendedBooks(Iterable<Book> likeBooks) {
    return _apiV2.getRecomandations(likeBooks);
  }

  @override
  Future<Either<Iterable<Book>>> searchTopBooks(String source, int count) {
    return _apiV1.searchTopBooks(source, count);
  }
}
